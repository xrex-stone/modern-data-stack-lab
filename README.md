# Introduction 
Adopt EtLT (**Extrac, Load, Tranformation**) methodology to process data.
The lower case `t` here means that doing some simple tranformation such as de-identification, chaning types, etc.

# Tech Stack
- Source Database : Mysql
- Data Warehouse : Postgres
- Extract Load Tool : meltano
- Transformation Tool : dbt
- Visualization : metabase


Architecture Diagram
![Alt text](/images/architecture.png)

# Scenario
This is a traditional order service. A customer can buy one more products in the system. There are three main tables : 
- customers : customer basic information.
- products : product information.
- orders : the order factor keeps the relationship between customers and products.

Entity Relationship Diagram
![Alt text](/images/ERD.png)

We will build our BI dashboard based on this scenario.

# Preparation

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

# install dbt depedencies
dbt deps
 ```

run dbt to generate models and lineage diagram
```sh
dbt run
dbt docs generate
dbt docs serve
```
The dbt lineage diagram
![Alt text](/images/dbt_lineage.png)

Other Command
```sh
dbt seed
dbt snapshot
```

## Launch Metabase
1. browse http://127.0.0.1:3000
2. set login fields
3. set date warehouse connection
4. enter Metabase
5. drop the data and draw a dashboard, finally, it looks like:
![Alt text](/images/metabase.png)

# Appendix

- install meltano : https://docs.meltano.com/guide/installation-guide/
- install dbt-postgres : https://docs.getdbt.com/docs/core/pip-install
