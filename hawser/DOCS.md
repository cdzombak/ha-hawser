# Hawser for Home Assistant

This add-on runs [Hawser](https://github.com/Finsys/hawser), a lightweight agent
that allows [Dockhand](https://dockhand.dev) to manage the Docker instance on your
Home Assistant host.

## Warning

This add-on grants Dockhand **full control over Docker** on your Home Assistant host.
This includes the ability to start, stop, and remove any container — including Home
Assistant itself. Only install this if you understand the implications and trust your
Dockhand installation.

## Modes

### Standard mode

Hawser listens for incoming connections from Dockhand. Use this when your HA instance
is directly reachable from your Dockhand server (e.g. on the same LAN).

Set **mode** to `standard` and configure the **port** (default `2376`). You will need
to expose this port in the add-on's network configuration.

You can set **bind_address** to restrict which network interface Hawser listens on
(e.g. `192.168.1.10` or `127.0.0.1`). By default, it listens on all interfaces
(`0.0.0.0`).

For production use, configure TLS by placing your certificate and key files in the
`/ssl` directory and setting **tls_cert** and **tls_key** to the filenames.

### Edge mode

Hawser initiates an outbound WebSocket connection to your Dockhand server. Use this
when your HA instance is behind NAT, a firewall, or has a dynamic IP.

Set **mode** to `edge`, provide the **dockhand_server_url** (e.g.
`wss://dockhand.example.com/api/hawser/connect`), and set the **token** from Dockhand.

## Configuration

| Option | Description |
|---|---|
| `mode` | `standard` or `edge` |
| `port` | Listen port for standard mode (default: `2376`) |
| `bind_address` | Listen address for standard mode (default: all interfaces) |
| `token` | Authentication token (required for edge mode, optional for standard) |
| `dockhand_server_url` | Dockhand WebSocket URL (required for edge mode) |
| `agent_name` | Human-readable name for this agent (default: hostname) |
| `log_level` | `debug`, `info`, `warn`, or `error` |
| `tls_cert` | TLS certificate filename in `/ssl` (standard mode) |
| `tls_key` | TLS key filename in `/ssl` (standard mode) |
| `skip_df_collection` | Disable disk usage collection |
| `heartbeat_interval` | Keepalive interval in seconds (default: `30`) |
| `request_timeout` | Request timeout in seconds (default: `30`) |
