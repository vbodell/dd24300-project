echo "Install packages"
sudo apt-get install git wget unzip -y
sudo apt-get install python python3-pip -y

echo "Update pip"
curl https://bootstrap.pypa.io/get-pip.py | sudo python3
pip install --upgrade setuptools

# For the packages used in the repo
pip install six>=1.13.0

# Get github repo
echo "Get repo"
git clone https://carpool-master:carpool-and-data@github.com/ErikBavenstrand/covid19.git
cd covid19
pip install -r requirements.txt

echo "Get Dataset"
#wget https://md-datasets-cache-zipfiles-prod.s3.eu-west-1.amazonaws.com/8h65ywd2jr-3.zip
#unzip COVID-19\ Dataset.zip

#python generate.py
#python train.py
