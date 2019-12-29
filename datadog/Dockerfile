FROM datadog/agent:latest

# to make openssl installation not ask for input
ENV DEBIAN_FRONTEND='noninteractive'

RUN apt update
RUN apt -y install -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' -f -q -y openssl
RUN apt -y install wget git zsh vim htop tree curl
RUN apt -y install netcat-openbsd nmap
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install
