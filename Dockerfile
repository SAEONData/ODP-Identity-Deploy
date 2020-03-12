FROM python:3.6

WORKDIR /srv

RUN git clone https://github.com/SAEONData/ODP-Identity.git
RUN git clone https://github.com/SAEONData/ODP-AccountsLib.git
RUN git clone https://github.com/SAEONData/Hydra-Admin-Client.git
RUN git clone https://github.com/SAEONData/Hydra-OAuth2-Blueprint.git

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN cd ODP-Identity && pip install .
RUN cd ODP-AccountsLib && pip install .
RUN cd Hydra-Admin-Client && pip install .
RUN cd Hydra-OAuth2-Blueprint && pip install .

CMD ["gunicorn", "-b 127.0.0.1:9024", "odpidentity:create_app()"]
