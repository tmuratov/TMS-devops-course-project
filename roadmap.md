### Roadmap

    [x] Control node setup
        [x] Bring up multiple VMs using Vagrant
            [x] use Ansible role for that, use jinja-templates with hostvars
        [x] script `install_ansible.sh` installs ansible, creates and configures remote_user on localhost
    [x] Jenkins + SSH agents
        [x] SSL/TLS
        [x] JCasC
        [x] DSL jobs -- add repository here as submodule
        [x] Git hooks on jobs (scm polling but anyway)
        [x] Notification - Telegram or/and email
        [ ] Stage view
        [x] Rework agent labels
    [x] Monitoring
        [x] run in containers
        [x] automated initialization
        [x] add some dashboards as code
        [ ] alert manager with Telegram notifications
    [ ] ELK-stack
        [ ] run in containers
        [ ] automated initialization
        [ ] add dashboards for background logs (services running in containers)
    [ ] Other
        [x] Run docker compose as systemd units, make wrapper-services
        [ ] Get something more complex for pipeline job

### QOL TODO:
    [ ] Rework remote_user configuration
        [ ] Get rid of NOPASSWD for sudo actions
        [ ] Manage root ssh access (`become` actions)
    [ ] Get rid of Vagrant, this setup is kinda lame
        [ ] I mean keep it separately from the whole ansible project
        [ ] Add some kind of Python script for inventory management
    [ ] Split inventory in separate files, e.g. masters.yml, agents.yml, monitoring.yml etc.
    [ ] Move `become` into roles' tasks instaed of declaring in playbooks. Don't sudo everything
