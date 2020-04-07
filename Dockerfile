FROM debian:buster

COPY . /EdgeMonitor

WORKDIR /EdgeMonitor 

RUN apt update

RUN apt install -y wget unzip python3 python3-pip libjpeg-dev libtiff5-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libatlas-base-dev

RUN wget https://storage.googleapis.com/download.tensorflow.org/models/tflite/coco_ssd_mobilenet_v1_1.0_quant_2018_06_29.zip

RUN unzip coco_ssd_mobilenet_v1_1.0_quant_2018_06_29.zip -d Sample_TFLite_model

RUN pip3 install -r requirements.txt

CMD ["python", "monitor.py"]
