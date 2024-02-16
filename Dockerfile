#Основа
FROM ubuntu:latest

#Встановлення параметрів середовища (optional)
ENV DEBIAN_FRONTEND=noninteractive

# Встановити потрібні пакети (або виконати будь-які інші bash команди допоможе RUN)
RUN apt-get update && apt-get install -y \
    build-essential \
    linux-headers-generic \
    vim git
#    package1 \
#    package2 \
#    package3

#Додаємо користувача
RUN useradd -u 1000 -m buildpc ; echo "buildpc:12345" | chpasswd ; \
echo "buildpc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#Копіюємо скрипт написаний нами(або будь що) з поточної директорії в контейнер 
COPY startup.sh /home/buildpc/startup.sh

#Робимо його виконуваним
RUN chmod a+x /home/buildpc/startup.sh

#Переходимо в директорію(якщо потрібно створимо)
WORKDIR /home/buildpc
#Сетапимо налаштування терміналу
ENV TERM xterm-256color

#Запускаємо скрипт при старті
ENTRYPOINT ["/home/buildpc/startup.sh"]

#або так
#CMD ["/bin/bash"]