# Introduction 
Adopt EtLT (**Extrac, Load, Tranformation**) methodology to process data.
The lower case `t` here means that doing some simple tranformation such as de-identification, chaning types, etc.

# Tech Stack
- Source Database : Mysql
- Data Warehouse : Postgres
- Extract Load Tool : meltano
- Transformation Tool : dbt
- Visualization : metabase

# Steps

## Launch databases
We launch two databases in this lab. One is MySQL as our raw data source, and another one is postgres acting as data warehouse.
```sh
docker-compose up -d
docker-compose ps
```

## Launch Extract and Load Process
We use meltano as our EL tool.

```sh
# virtual env
python3 -m venv meltano-env
# windows
meltano-env\Scripts\activate.bat
meltano-env\Scripts\deactivate.bat
# or mac/linux-like
source meltano-env/bin/activate

python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install meltano

meltano init extract_load
cd extract_load

meltano lock --update --all
meltano install

# rename .env.sample to .env in ./extrac_load and make sure if database variables is correct
meltano run mydb target-postgres
# add mydb-transformtion in pipeline to see what's different in warehouse
meltano run mydb mydb-transformtion target-postgres

```


## Launch Transformation Process
Here we use dbt tool to process tranformation.

```sh
# virtual env
python3 -m venv venv-dbt
# windows
venv-dbt\Scripts\activate.bat
venv-dbt\Scripts\deactivate.bat
# or mac/linux-like
source venv-dbt/bin/activate

# install dbt for postgres
pip install dbt-postgres

# Which database would you like to use?
# [1] postgres
# Enter a number: 
1
```
 modify dbt profile for setting database infomation (refer to ./dbt/profiles.yml.sample)
 ```sh
 vi ~/.dbt/profiles.yml
 ```

work on dbt
 ```sh
cd transformation
 
# make sure if connecton works well
dbt debug
# should show -> 13:41:27  All checks passed!

dbt seed
dbt snapshot
dbt run
 ```


# Appedix

- install meltano : https://docs.meltano.com/guide/installation-guide/
- install dbt-postgres : https://docs.getdbt.com/docs/core/pip-install
