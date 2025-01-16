# Mymp3
Meu repositório online de musicas com sistema de playlists/pastas feito em PHP que se integra com Docker, usando uma imagem do xampp como base, Kubernets para orquestração dos pods e com o Jenkins para deploy automatico<br>
<img src='fotodoprojeto.png'>

## Como o sistema funciona

No menu lateral, você encontrará cinco ícones. O ícone Home leva você a uma página com uma breve descrição do projeto. Abaixo dele, está o ícone Banco de Músicas, onde serão exibidas todas as músicas que foram carregadas através da página de upload. Em seguida, o ícone Playlists oferece acesso a playlists organizadas por gênero, além de permitir que você crie suas próprias playlists personalizadas. Para isso, basta clicar no ícone "Criar Pasta" e fazer o upload das suas músicas. Abaixo, você encontra o ícone Upload de Músicas, que leva à página responsável por enviar novas músicas para o projeto. Por fim, o último ícone permite que você retorne à página de login.

## Explicando o código

A "mágica" por trás da aplicação reside em três funções principais. A primeira função é responsável por escanear diretórios e exibir os arquivos contidos neles em páginas PHP. A segunda função permite o upload de arquivos MP3 para um diretório específico, que será posteriormente escaneado pela primeira função e exibido em uma página PHP. Por fim, a terceira função cria um novo diretório (playlist) e uma página correspondente para exibir os arquivos e permitir o upload de novos MP3s para essa playlist. Com essas três funcionalidades, a aplicação se torna dinâmica, permitindo o upload de arquivos MP3, seu armazenamento, exibição para o usuário e organização dentro de pastas.

## Install

A aplicação foi pensada para rodar em containers com Docker, uma vez tendo o docker instalado (sinta-se livre para usar o script de instalação do docker que deixei na raiz do repisotório), com um esse simples comando você já terá a aplicação rodando em seu ambiente:
```
docker run -d -p 8080:80 --name mymp3 andradesysadmin/mymp3:latest
```
A aplicação estará disponivel na porta 8080 com o login e senha **admin**

## Kubernets Install

```bash
#Clone repository and chose them
git clone https://github.com/homemlinux/mymp3-kubernets
cd mymp-kubernets

#Create kind cluster and apply the manifests
kind create cluster --config kind/kind-config.yaml
kubectl apply -f manifests/
```
Depois disso, você pode acessar a aplicação com o IP do Node Worker na porta 30080, algo assim:

```
http://172.19.0.4:30080/
```

## Executando os testes

Caso queira testar o upload de arquivos eu deixei um arquivo mp3 nos arquivos do projeto: <a href="https://github.com/andradedevweb/mymp3/blob/main/audio.mp3">clique aqui para acessar</a>

Você pode ir na pagina de playlists e testar o sistema de criação de playlists/pastas, inserir musicas nas playlists/banco de musicas ou simplesmente ouvir as as musicas já incluidas no sistema.

## 🛠 Construído com

* [PHP](https://www.php.net/) - Linguagem de script usada
* [Kubernetes](https://kubernetes.io) - Orquestrador de containers
* [Docker](https://www.docker.com/) - Container engine usada
* [Jenkins](https://www.jenkins.io/) - Servidor de automação CI/CD
* [Bootstrap](https://getbootstrap.com/) - Framework frontend usado
* [Xampp](https://www.apachefriends.org/pt_br/index.html) - Servidor local usado
* [VsCode](https://code.visualstudio.com/) - Editor de código usado
