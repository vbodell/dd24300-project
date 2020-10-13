echo "Install packages"
sudo apt-get -q update
sudo apt-get -q install git wget unzip -y
sudo apt-get -q install python python3-pip -y

echo "Update pip"
curl -s https://bootstrap.pypa.io/get-pip.py | sudo python3
sudo pip install --upgrade setuptools

# Required to get packages working
sudo apt-get -q install libgl1-mesa-glx -y
sudo pip install six>=1.13.0

# Get environment variables
APIKEY=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/APIKEY -H Metadata-Flavor:Google)
GITHUB_PWD=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/GITHUB_PWD -H Metadata-Flavor:Google)
FETCH_AND_PROCESS_DATASET=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/FETCH_AND_PROCESS_DATASET -H Metadata-Flavor:Google)

echo "Using env vars APIKEY=$APIKEY, GITHUB_PWD=$GITHUB_PWD, FETCH_AND_PROCESS_DATASET=$FETCH_AND_PROCESS_DATASET"

# Get github repo
echo "Get repo"
git clone https://carpool-master:$GITHUB_PWD@github.com/ErikBavenstrand/covid19.git
cd covid19
sudo pip install -r requirements.txt

if $FETCH_AND_PROCESS_DATASET; then
    echo "Get Egypt Dataset file, can take a couple of minutes..."
    wget -q https://md-datasets-cache-zipfiles-prod.s3.eu-west-1.amazonaws.com/8h65ywd2jr-3.zip
    echo "Unzipping dataset. Will probably also take a little while..."
    sudo -q unzip 8h65ywd2jr-3.zip
    sudo -q unzip COVID-19\ Dataset.zip
    sudo rm 8h65ywd2jr-3.zip COVID-19\ Dataset.zip

    echo "Generate the tfrecords"
    sudo python3 generate.py
fi

#sudo wandb login $APIKEY
#sudo python3 train.py
