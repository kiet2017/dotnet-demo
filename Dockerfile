FROM centos:centos7
RUN rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
RUN yum -y install libicu
RUN yum -y install dotnet-sdk-2.1
RUN yum -y install openssh-clients

RUN mkdir -p /src
RUN mkdir -p /dotnetdemo
COPY ["socket.csproj","/src"]
COPY ["Program.cs","/src"]
WORKDIR /src

RUN dotnet build socket.csproj -c Release -o /dotnetdemo
RUN dotnet publish socket.csproj -c Release -o /dotnetdemo

###ENIRYPOINT ["dotnet","/dotnetdemo/socket.dll"]
EXPOSE 30868
CMD ["dotnet","/dotnetdemo/socket.dll"]
