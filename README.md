# sing_ruleset

Personal sing-box rule sets.

Each `*.json` file is the source rule set. Run `./my.sh` to compile the matching
`*.srs` file and generate Clash-compatible `*.list` and `*.yaml` files.

## applications

`applications.*` is generated from:

https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/applications.txt

The upstream file is a Clash payload containing `PROCESS-NAME` rules. In this
repository it is converted to sing-box `process_name` rules in
`applications.json`, then compiled/generated as:

- `applications.srs`
- `applications.list`
- `applications.yaml`

## application

`application.*` is a local custom process-name rule set and is maintained
separately from `applications.*`.
