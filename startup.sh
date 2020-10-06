echo "Install packages"
sudo apt-get install git -y
sudo apt-get install python python3-pip -y

# Get github repo
echo "Get repo"
git clone https://carpool-master:carpool-and-data@github.com/ErikBavenstrand/covid19.git
cd covid19
pip3 install -r requirements.txt

echo "Get Dataset"
#wget https://md-datasets-cache-zipfiles-prod.s3.eu-west-1.amazonaws.com/8h65ywd2jr-3.zip
#unzip COVID-19\ Dataset.zip

#python generate.py
#python train.py
