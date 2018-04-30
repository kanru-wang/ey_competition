import warnings
import data
import pandas as pd

def build_data(train_feature_df, train_outcome_df, test_feature_df):
    # Combine train feature df and test feature df for pre-processing
    train_feature_df['train_test_tag'] = 'train'
    test_feature_df['train_test_tag'] = 'test'
    combined_df = pd.concat([train_feature_df, test_feature_df], axis = 0)
    
    # Do the pre-processing
    combined_df_cleaned = clean_feature_df(combined_df)
    #train_outcome_df_encoded = encode_outcome_df(train_outcome_df)
        
    # Seperate train and test
    train_feature_df_cleaned = combined_df_cleaned.loc[combined_df_cleaned['train_test_tag__train'] == 1].drop(
        ['train_test_tag__train', 'train_test_tag__test'], axis = 1)
    test_feature_df_cleaned = combined_df_cleaned.loc[combined_df_cleaned['train_test_tag__test'] == 1].drop(
        ['train_test_tag__train', 'train_test_tag__test'], axis = 1)
    
    # Construct the data object using cleaned feature
    return data.ClassificationData(train_feature_df_cleaned, train_outcome_df, test_feature_df_cleaned)


def clean_feature_df(df_raw):
    return (df_raw
            # drop all unused columns and dependent variables
            .drop(['LOCATION'], axis=1)
            .pipe(data.cleaner)
            # Remove all columns which are constant - removed for testing
            #.pipe(lambda x: x.loc[:, x.apply(pd.Series.nunique) != 1])
            # Each column need to in this case have at least xx cases
            #.pipe(lambda x: x.loc[:, x.apply(pd.Series.sum) >= 80])
            .drop(['GENDER__men'], axis=1)
            )


def encode_outcome_df(df_raw):
    return(df_raw.replace(to_replace = ['functional', 'functional needs repair', 'non functional'], 
                          value = [2, 1, 0]))
