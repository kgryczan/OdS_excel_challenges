import pandas as pd
import re

input_data = {
    'ID': ["M-0356", "M-0815", "M-0994", "M-1113", "M-1521", "M-1709", "M-1871", "M-2363", "M-2886", "M-3079", "M-3992", "M-4215", "M-4410"],
    'Employee': ["Nolan Harris", "Norton, Kyla", "Dee J. Farley", "Kahue, Sam", "Lewis Gardner", "Perry, L'Arron", "Cedric Martin", "Kingwood, Juanita", "Barrera, Albertina", "Lovey G. Montoya", "Elberto Lang", "James Penn", "Nicolazzo, Thiago"]
}

def extract_surname(x):
    if re.search(',', x):
        return re.search(r'\w+', x).group()
    elif re.search('\.', x):
        return re.search(r'\w+$', x).group()
    else:
        return re.findall(r'\w+', x)[-1]

df = pd.DataFrame(input_data)
df['Surname'] = df['Employee'].apply(extract_surname)
df = df.sort_values('Surname').drop('Surname', axis=1).reset_index(drop=True)

print(df)