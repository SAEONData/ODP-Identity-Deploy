# ODP-Identity-Deploy

***Note: This work has been incorporated into, and superseded by, the [Open Data Platform](https://github.com/SAEONData/Open-Data-Platform) project.***

Docker-based deployment of the [ODP Identity](https://github.com/SAEONData/ODP-Identity) service.

## Installation

Create a `.env` file in the project directory on the target machine, and set the following environment variables:

- **`FLASK_ENV`**: deployment environment: `development`|`testing`|`staging`|`production`
- **`FLASK_SECRET_KEY`**: Flask [SECRET_KEY](https://flask.palletsprojects.com/en/1.1.x/config/#SECRET_KEY)
- **`PROXY_IP`**: (optional) IP address of reverse proxy if running on a different host
- **`DATABASE_URL`**: ODP accounts database URL
- **`MAIL_SERVER`**: IP / hostname of mail server used for sending email verifications / password resets
- **`HYDRA_PUBLIC_URL`**: URL of the Hydra public API
- **`HYDRA_ADMIN_URL`**: URL of the Hydra admin API
- **`HYDRA_LOGIN_EXPIRY`**: number of seconds to remember a successful login
- **`OAUTH2_CLIENT_SECRET`**: client secret for the identity service UI, as registered in Hydra

_N.B. Make sure to generate cryptographically strong secrets for `FLASK_SECRET_KEY` and `OAUTH2_CLIENT_SECRET`,
and to back these up securely._

Start the identity service container in the background:

    docker-compose up -d

## Upgrading

In the project directory on the target machine, run:

    git pull

Update the `.env` file as necessary, then run:

    docker-compose down
    docker-compose build --no-cache
    docker-compose up -d

## Notes

### Upgrading dependencies

To upgrade dependencies and re-generate the `requirements.txt` file for a new release,
carry out the following steps:

1. Activate the Identity Service virtual environment.
1. Upgrade Python libraries as necessary.
1. Ensure that unit tests for the Identity Service and project dependencies all pass.
1. Run the following command:
`pip freeze | sed -E '/^(-e\s|pkg-resources==)/d' > requirements.txt`
