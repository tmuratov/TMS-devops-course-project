### Roadmap

    [x] Control node setup
        script `install_ansible.sh` installs ansible, creates and configures remote_user on localhost
    [x] Jenkins + SSH agents
        [x] SSL/TLS
        [x] JCasC
        [ ] DSL jobs -- add repository here as submodule
        [ ] Git hooks on jobs
        [ ] Notification - Telegram or/and email
    [ ] Monitoring
        [ ] run in containers
        [ ] automated initialization
        [ ] add some dashboards as code
        [ ] monitoring with notifications is a must-do
    [ ] ELK-stack
        [ ] run in containers
        [ ] automated initialization
        [ ] add dashboards for background logs (services running in containers)

### QOL TODO:
    [ ] Rework remote_user configuration
        [ ] Get rid of NOPASSWD for sudo actions
        [ ] Manage root ssh access (`become` actions)
    [ ] Get rid of Vagrant, this setup is kinda lame
        [ ] I mean keep it separately from the whole ansible project
        [ ] Add some kind of Python script for inventory management
    [ ] Split inventory in separate files, e.g. masters.yml, agents.yml, monitoring.yml etc.
    [ ] Move `become` into roles' tasks instaed of declaring in playbooks. Don't sudo everything
    [ ] Manage prerequisites, filter prerequisites by host type
