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
    <a class="logo-animada" href="Index.jsp">⚽</a><h1>Boleirones</h1>
  	  </header>

<div class="wrap">
 
<div class="card">
	
       
    
    <form method="get" action="Dashboard.jsp" class="topbar">
            <label style="color:#fff;margin-right:6px">Filtrar por Time:</label>
            <select name="filterTime" onchange="this.form.submit()">
                <option value="">-- Todos --</option>
                <% for (Time t : times) { %>
                    <option value="<%= t.getIdTime() %>" 
                        <%= (filterId!=null && filterId==t.getIdTime()) ? "selected" : "" %>>
                        <%= t.getNome() %> (<%= t.getPontos() %> pts)
                    </option>
                <% } %>
            </select>
            <a href="Dashboard.jsp" class="btn" style="margin-left:10px">Limpar</a>
             <a class="btn" href="Form.jsp?entidade=Time">Adicionar Time</a>
        <a class="btn" href="Form.jsp?entidade=Jogador">Adicionar Jogador</a>
        <a class="btn" href="Form.jsp?entidade=Estadio">Adicionar Estádio</a>
        <a class="btn" href="Form.jsp?entidade=Jogo">Adicionar Jogo</a>
        <a class="btn" href="Form.jsp?entidade=Gol">Adicionar Gol</a>
        </form>
    </div>
	<div class="card">
        <h2>Classificação</h2>
        <table>
            <tr><th>Time</th><th>Cidade</th><th>Pontos</th><th>Ações</th></tr>

            <% for (Time t : times) { %>
                <tr>
                    <td><%= t.getNome() %></td>
                    <td><%= t.getCidade() %></td>
                    <td><%= t.getPontos() %></td>
                    <td>
                        <a href="Form.jsp?entidade=Time&id=<%= t.getIdTime() %>">Editar</a>
                        <a href="Delete.jsp?entidade=Time&id=<%= t.getIdTime() %>">Excluir</a>
                    </td>
                </tr>
            <% } %>

        </table>
    </div>
 
    <div class="card">
        <h2>Jogos <small style="color:#999">(<%= filterId!=null ? "":"" %>)</small></h2>
        <table>
            <tr><th>ID</th><th>Casa</th><th>Fora</th><th>Estádio</th><th>Horário</th><th>Resultado</th><th>Ações</th></tr>

            <% for (Jogo j : jogos) {
                   if (filterId != null) {
                       if (j.getIdTimeCasa() != filterId && j.getIdTimeFora() != filterId) continue;
                   }
                   Time casa = timeDao.buscarPorId(j.getIdTimeCasa());
                   Time fora = timeDao.buscarPorId(j.getIdTimeFora());
                   Estadio est = estDao.buscarPorId(j.getIdEstadio());
            %>

                <tr>
                    <td><%= j.getIdJogo() %></td>
                    <td><%= casa != null ? casa.getNome() : "—" %> (<%= j.getGolsTimeCasa() %>)</td>
                    <td><%= fora != null ? fora.getNome() : "—" %> (<%= j.getGolsTimeFora() %>)</td>
                    <td><%= est != null ? est.getNomeEstadio() : "—" %></td>
                    <td><%= j.getHorario() %></td>
                    <td><%= j.getGolsTimeCasa() %> x <%= j.getGolsTimeFora() %></td>
                    <td>
                        <a href="Form.jsp?entidade=Jogo&id=<%= j.getIdJogo() %>">Editar</a> |
                        <a href="Delete.jsp?entidade=Jogo&id=<%= j.getIdJogo() %>" onclick="return confirm('Excluir jogo?')">Excluir</a>
                    </td>
                </tr>

            <% } %>
        </table>
    </div>
 
    <div class="card">
    
        <h2>Jogadores</h2>
        <table>
            <tr><th>Nome</th><th>Número</th><th>Posição</th><th>Time</th><th>Gols</th><th>Ações</th></tr>

            <%
    for (Jogador j : jogDao.listarTodos()) {

        if (filterId != null && j.getIdTime() != filterId) {
            continue; 
        }

        Time tm = timeDao.buscarPorId(j.getIdTime());
%>
                <tr>
                    <td><%= j.getNome() %></td>
                    <td><%= j.getNumero() %></td>
                    <td><%= j.getPosicao() %></td>
                    <td><%= tm != null ? tm.getNome() : "—" %></td>
                    <td><%= j.getGols() %></td>
                    <td><a href="Form.jsp?entidade=Jogador&id=<%= j.getIdJogador() %>">Editar</a></td>
                    <td><a href="Delete.jsp?entidade=Jogador&id=<%= j.getIdJogador() %>">Excluir</a></td>
                </tr>
            <% } %>

        </table>
    </div>
 
    <div class="card">
        <h2>Artilheiros Gerais</h2>
        <table>
            <tr><th>Nome</th><th>Time</th><th>Gols</th><th>Ações</th></tr>

            <%
                List<Jogador> rankingArtilharia = jogDao.listarArtilheiros();

                for (Jogador jg : rankingArtilharia) { 
                    if (filterId != null && jg.getIdTime() != filterId) {
                        continue;
                    } 
                    if (filterId == null && jg.getGols() == 0) continue; 
                    Time timeArtilheiro = timeDao.buscarPorId(jg.getIdTime());
            %>

                <tr>
                    <td><%= jg.getNome() %></td>
                    <td><%= timeArtilheiro != null ? timeArtilheiro.getNome() : "—" %></td> 
                    <td>**<%= jg.getGols() %>**</td> 
                    <td>
                        <a href="Form.jsp?entidade=Jogador&id=<%= jg.getIdJogador() %>">Editar</a>
                        <a href="Delete.jsp?entidade=Jogador&id=<%= jg.getIdJogador() %>">Excluir</a>
                    </td>
                </tr>

            <% } %>

        </table>
    </div>
    
    <div class="card">
    <h2>Estádios</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Cidade</th>
            <th>Capacidade</th>
            <th>Ações</th>
        </tr>

        <%
            List<Estadio> estadios = estDao.listarTodos();

            for (Estadio e : estadios) {
        %>

        <tr>
            <td><%= e.getIdEstadio() %></td>
            <td><%= e.getNomeEstadio() %></td>
            <td><%= e.getCidade() %></td>
            <td><%= e.getCapacidade() %></td>
            <td>
                <a href="Form.jsp?entidade=Estadio&id=<%= e.getIdEstadio() %>">Editar</a> |
                <a href="Delete.jsp?entidade=Estadio&id=<%= e.getIdEstadio() %>"
                   onclick="return confirm('Excluir estádio?')">Excluir</a>
            </td>
        </tr>

        <% } %>

    </table>
</div>
   
    

</div>



</body>
</html>
