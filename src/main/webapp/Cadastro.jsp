<%@ page import="java.util.*, model.*, dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    TimeDAO timeDao = new TimeDAO();
    JogadorDAO jogDao = new JogadorDAO();
    GolDAO golDao = new GolDAO();
    EstadioDAO estDao = new EstadioDAO();
    JogoDAO jogoDao = new JogoDAO();

    List<Time> times = timeDao.listarTodos();
    List<Jogo> jogos = jogoDao.listarTodos();

    String filterTime = request.getParameter("filterTime");
    Integer filterId = null;
    if (filterTime != null && !filterTime.isEmpty()) {
        filterId = Integer.parseInt(filterTime);
    }

    Collections.sort(times, new Comparator<Time>() {
        public int compare(Time a, Time b) {
            return Integer.compare(b.getPontos(), a.getPontos());
        }
    });
%>

<html>
<head>
    <title>Boleirones</title>
     <link rel="stylesheet" type="text/css" href="css/styles.css">
     <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
     
   
</head>

<body>

<header>
    <h1>Boleirones</h1>
    <div>
        <a class="btn" href="Dashboard.jsp">Inicio</a>
    </div>
</header>

<div class="wrap">

    <div class="card">
        <div>
        <a class="btn" href="Form.jsp?entidade=Time">Adicionar Time</a>
        <a class="btn" href="Form.jsp?entidade=Jogador">Adicionar Jogador</a>
        <a class="btn" href="Form.jsp?entidade=Estadio">Adicionar Estádio</a>
        <a class="btn" href="Form.jsp?entidade=Jogo">Adicionar Jogo</a>
        <a class="btn" href="Form.jsp?entidade=Gol">Adicionar Gol</a>
    </div>
 
</div>

</div>

</body>
</html>
