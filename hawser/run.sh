#!/usr/bin/with-contenv bashio

MODE=$(bashio::config 'mode')

# Common settings
export LOG_LEVEL=$(bashio::config 'log_level')
export DOCKER_SOCKET=/var/run/docker.sock
export STACKS_DIR=/data/stacks

AGENT_NAME=$(bashio::config 'agent_name')
if bashio::var.has_value "${AGENT_NAME}"; then
  export AGENT_NAME
fi

TOKEN=$(bashio::config 'token')
if bashio::var.has_value "${TOKEN}"; then
  export TOKEN
fi

HEARTBEAT_INTERVAL=$(bashio::config 'heartbeat_interval')
if bashio::var.has_value "${HEARTBEAT_INTERVAL}"; then
  export HEARTBEAT_INTERVAL
fi

REQUEST_TIMEOUT=$(bashio::config 'request_timeout')
if bashio::var.has_value "${REQUEST_TIMEOUT}"; then
  export REQUEST_TIMEOUT
fi

SKIP_DF=$(bashio::config 'skip_df_collection')
if bashio::var.true "${SKIP_DF}"; then
  export SKIP_DF_COLLECTION=1
fi

if [ "${MODE}" = "edge" ]; then
  DOCKHAND_SERVER_URL=$(bashio::config 'dockhand_server_url')
  if ! bashio::var.has_value "${DOCKHAND_SERVER_URL}"; then
    bashio::log.fatal "Edge mode requires dockhand_server_url to be set"
    bashio::exit.nok
  fi
  export DOCKHAND_SERVER_URL

  if ! bashio::var.has_value "${TOKEN}"; then
    bashio::log.fatal "Edge mode requires token to be set"
    bashio::exit.nok
  fi

  bashio::log.info "Starting Hawser in edge mode -> ${DOCKHAND_SERVER_URL}"
else
  export PORT=$(bashio::config 'port')

  BIND_ADDRESS=$(bashio::config 'bind_address')
  if bashio::var.has_value "${BIND_ADDRESS}"; then
    export BIND_ADDRESS
  else
    export BIND_ADDRESS="0.0.0.0"
  fi

  TLS_CERT=$(bashio::config 'tls_cert')
  TLS_KEY=$(bashio::config 'tls_key')
  if bashio::var.has_value "${TLS_CERT}"; then
    export TLS_CERT="/ssl/${TLS_CERT}"
    export TLS_KEY="/ssl/${TLS_KEY}"
  fi

  bashio::log.info "Starting Hawser in standard mode on ${BIND_ADDRESS}:${PORT}"
fi

exec /usr/bin/hawser
