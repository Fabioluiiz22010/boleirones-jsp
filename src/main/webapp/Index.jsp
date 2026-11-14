<%@ page import="java.util.*, model.*, dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Boleirones - Gestão de Campeonato de Futebol</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    
</head>

<body>

<header>
    <h1 class="logo-animada">⚽</h1><h1>Boleirones</h1>
    <div>
        <a class="btn" href="Dashboard.jsp">Dashboard</a>
        <a class="btn" href="Cadastro.jsp">Cadastros</a>
    </div>
</header>

<div class="wrap">

    <div class="card">
        <p><strong>Bem-vindo ao Boleirones!</strong></p>
        <p>Esse projeto foi desenvolvido para a gestão de campeonatos amadores de futebol (como campeonatos de Várzea, Universitário e afins). O objetivo principal é proporcionar uma plataforma mais organizada e de fácil acesso para os administradores desses eventos.</p>
        
        <p>O sistema conta com a administração das seguintes tabelas:</p>
        <ul>
            <li><strong>Times</strong> - Cadastro e gerenciamento dos times participantes.</li>
            <li><strong>Jogadores</strong> - Cadastro e gerenciamento dos jogadores dos times.</li>
            <li><strong>Jogos</strong> - Registro dos jogos e seus resultados.</li>
            <li><strong>Gols</strong> - Acompanhamento dos gols feitos pelos jogadores em cada jogo.</li>
            <li><strong>Estádios</strong> - Informações sobre os "estádios" utilizados nas partidas.</li>
        </ul>
        
        <p>A ideia é facilitar o gerenciamento e fornecer uma visão clara sobre a performance dos times e jogadores durante o campeonato.</p>

        <p>O funcionamento da plataforma é simples: ao adicionar Times, jogadores e Estádios, conseguimos marcar os jogos, utilizando as chaves estrangeiras (FK) para os times e estádios. Durante os jogos, podemos anotar quantos gols foram feitos, registrando também quem fez o gol e em qual minuto do jogo. Esses dados ficam salvos na tabela de gols, e a quantidade de gols é somada à tabela de jogadores, permitindo criar uma tabela de artilharia do campeonato.</p>
        
        <p>Ao final de cada jogo, a plataforma automaticamente calcula os pontos para as equipes: o vencedor recebe 3 pontos, o perdedor não ganha pontos, e, em caso de empate, ambos os times recebem 1 ponto.</p>

        <p>A plataforma também pode ser adaptada para campeonatos de E-esportes amadores, como EAFC ou Efootball, com um funcionamento semelhante.</p>

        <p>Além disso, o sistema é flexível o suficiente para poder gerenciar tabelas com relacionamentos de muitos para muitos (N:N), como por exemplo, jogadores em diferentes times ou competições.</p>
    </div>

</div>

 

</body>
</html>
