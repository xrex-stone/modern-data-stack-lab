# Introduction 
Adopt EtLT methodology to process data.

# Tech Stack
- Source Database : Mysql
- Data Warehouse : Postgres
- Extract Load Tool : meltano
- Transformation Tool : dbt
- Visualization : metabase

# Command Line

```sh
docker-compose up -d
docker-compose ps


# virtual env
cd extract_load
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

# Appedix

- install meltano : https://docs.meltano.com/guide/installation-guide/

