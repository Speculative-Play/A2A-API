class MatchProfile < ApplicationRecord
    has_many                :match_question_answers,       dependent: :destroy
    has_many                :starred_match_profiles,       dependent: :destroy
    has_many                :favourited_match_profiles,    dependent: :destroy
    has_one_attached        :avatar,                       dependent: :destroy
    serialize               :languages,                    Array   
    serialize               :sisters,                      Array   
    serialize               :brothers,                     Array   
    serialize               :about_me,                     Array   

    # Database Seeding Arrays

    # first_names
    HINDU_GIRL_FIRST_NAMES = ['Nina', 'Shweta', 'Reena', 'Sonia', 'Tina', 'Meher']
    HINDU_BOY_FIRST_NAMES = ['Sameer', 'Amir']
    SIKH_GIRL_FIRST_NAMES = ['Gurupreet', 'Amanpreet', 'Gurunoor', 'Harpreet', 'Noor', 'Preet', 'Tavleen']
    SIKH_BOY_FIRST_NAMES = ['Gurupreet', 'Amanpreet', 'Gurunoor', 'Harpreet', 'Noor', 'Preet', 'Tavleen']
    MUSLIM_GIRL_FIRST_NAMES = ['Dinaz', 'Meher', 'Tanaz', 'Tina', 'Reena']
    MUSLIM_BOY_FIRST_NAMES = ['Sameer', 'Farzan', 'Azman', 'Adel', 'Jehangir', 'Zubin', 'Abraham', 'Amir', 'Mohammad', 'Ali', 'Salman', 'Akbar']
    CHRISTIAN_GIRL_FIRST_NAMES = ['Shweta', 'Daisy', 'Tina', 'Sonia', 'Nina', 'Reena', 'Tina']
    CHRISTIAN_BOY_FIRST_NAMES = ['Joseph', 'John', 'Samual', 'Martin', 'George', 'Abraham']
    PARSI_GIRL_FIRST_NAMES = ['Dinaz', 'Tanaz']
    PARSI_BOY_FIRST_NAMES = ['Cyrus', 'Farzan', 'Azman', 'Adel', 'Jehangir', 'Zubin', 'Porus']
    BUDDHIST_GIRL_FIRST_NAMES = ['Nina', 'Shweta', 'Reena', 'Sonia', 'Tina', 'Meher']
    BUDDHIST_BOY_FIRST_NAMES = ['Sameer', 'Amir']
    JAIN_GIRL_FIRST_NAMES = ['Nina', 'Shweta', 'Reena', 'Sonia', 'Tina', 'Meher']
    JAIN_BOY_FIRST_NAMES = ['Sameer', 'Amir']

    # last_names

    # cities

    # countries

    # birth_countries

    # languages
    LANGUAGES = ['Tamil', 'Telugu', 'Malayalam', 'Kannada', 'Hindi', 'Marathi', 'Bengali', 'Gujarati', 'Angika', 'Arunachali', 'Assamese', 'Awadhi', 'Bhojpuri', 'Brij', 'Bihari', 'Badaga', 'Chatisgarhi', 'Dogri', 'English', 'French', 'Garhwali', 'Garo', 'Haryanvi', 'Himachali/Pahari', 'Kanauji', 'Kashmiri', 'Khandesi', 'khasi', 'Konkani', 'Koshali', 'Kumaoni', 'Kutchi', 'Lepcha', 'Ladacki', 'Magahi', 'Maithili', 'Manipuri', 'Marwari', 'Miji', 'Mizo', 'Monpa', 'Nicobarese', 'Nepali', 'Oriya', 'Punjabi', 'Rajasthani', 'Sanskrit', 'Santhali', 'Sindhi', 'Sourashtra', 'Tripuri', 'Tulu', 'Urdu']

    JOBS = ['Doctor', 'Engineer', 'Chartered Accountant', 'Company Secretary', 'Lawyer', 'Pilot', 'Chef', 'College Professor', 'Architect', 'Investment Banker', 'Scientist', 'IAS Officer', 'Dentist', 'Chief Executive Officer (CEO)', 'Police Officer', 'Indian Army Soldier', 'Civil Services']
    DEGREES = ['M.B.B.S', 'B.Tech', 'B.A. Accounting', 'B.A. Public Administration', 'LLB/LLM', 'B.Sc.', 'BHM', 'PhD', 'BArch', 'B.Com', 'B.Sc.', 'Bachelor Degree', 'BDS', 'Bachelor Degree', 'Law Enforcement Degree', 'BPP', 'Bachelor Degree']

    # religions
    RELIGIONS = ['Buddhist', 'Christian', 'Hindu', 'Jain', 'Muslim', 'Parsi', 'Sikh']

    INDIAN_CITIES = ["Mumbai", "Kolkata", "Chennai", "Bangalore", "Hyderabad", "Ahmedabad", "Pune", "Visakhapatnam", "Andhra Pradesh Capital Region", "Surat", "Jaipur", "Coimbatore", "Kanpur", "Nagpur", "Raipur", "Kochi", "Kozhikode", "Nāsik", "Salem", "Thiruvananthapuram", "Madurai", "Jodhpur", "Chandigarh", "Mysore", "Udaipur", "Puducherry", "Solan", "Shimla", "Srīnagar", "Jammu", "Bhopāl", "Ghāziābād", "Lucknow", "Mangalore", "Goa", "Nellore", "Palampur", "Bellary", "Allahābād"]
    # MatchProfile::ARRAY.sample 

end
