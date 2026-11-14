<%@ page import="java.util.*, model.*, dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% 
    String entidade = request.getParameter("entidade");
    String idParam = request.getParameter("id");
  
    TimeDAO timeDao = new TimeDAO();
    JogadorDAO jogadorDao = new JogadorDAO();
    EstadioDAO estadioDao = new EstadioDAO();
    JogoDAO jogoDao = new JogoDAO();
    GolDAO golDao = new GolDAO();
 
    Time time = null;
    Jogador jogador = null;
    Estadio estadio = null;
    Jogo jogo = null;
    Gol gol = null;

    if (idParam != null && !idParam.isEmpty()) {
        int id = Integer.parseInt(idParam);
        if ("Time".equals(entidade)) time = timeDao.buscarPorId(id);
        if ("Jogador".equals(entidade)) jogador = jogadorDao.buscarPorId(id);
        if ("Estadio".equals(entidade)) estadio = estadioDao.buscarPorId(id);
        if ("Jogo".equals(entidade)) jogo = jogoDao.buscarPorId(id);
        if ("Gol".equals(entidade)) gol = golDao.buscarPorId(id);  
    } 
    List<Time> times = timeDao.listarTodos();
    List<Estadio> estadios = estadioDao.listarTodos();
 
%>
<html>
<head>
    <title>Cadastro - Boleirones</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
</head>
<body>

<header>
    <a class="logo-animada" href="Dashboard.jsp">⚽</a><h1>Boleirones</h1> 
    <div>
        <a class="btn" href="Dashboard.jsp">Inicio</a>
    </div>
</header>
<div class="container">
    <h2 style="text-align:center;"> 
        <%= entidade != null ? (idParam != null && !idParam.isEmpty() ? "Editar " : "Adicionar ") + entidade : "Formulário" %>
    </h2>

    <form action="Salvar.jsp" method="post">
        <input type="hidden" name="entidade" value="<%= entidade %>"/>
        <input type="hidden" name="id" value="<%= idParam != null ? idParam : "" %>"/>
 
        <% if ("Time".equals(entidade)) { %>
            <div class="form-row">
                <label>Nome do Time</label>
                <input type="text" name="nome" value="<%= time != null ? time.getNome() : "" %>" required/>
            </div>
            <div class="form-row">
                <label>Cidade</label>
                <input type="text" name="cidade" value="<%= time != null ? time.getCidade() : "" %>"/>
            </div>
        <% } %> 
        <% if ("Jogador".equals(entidade)) { %>
            <div class="form-row"><label>Nome</label>
                <input type="text" name="nome" value="<%= jogador != null ? jogador.getNome() : "" %>" required/></div>
            <div class="form-row"><label>Posição</label>
                <select name="posicao" required>
                    <option value="">Selecione</option>
                    <option value="Goleiro" <%= jogador != null && "Goleiro".equals(jogador.getPosicao()) ? "selected" : "" %>>Goleiro</option>
                    <option value="Zagueiro" <%= jogador != null && "Zagueiro".equals(jogador.getPosicao()) ? "selected" : "" %>>Zagueiro</option>
                    <option value="Lateral" <%= jogador != null && "Lateral".equals(jogador.getPosicao()) ? "selected" : "" %>>Lateral</option>
                    <option value="Meio Campo" <%= jogador != null && "Meio Campo".equals(jogador.getPosicao()) ? "selected" : "" %>>Meio Campo</option>
                    <option value="Atacante" <%= jogador != null && "Atacante".equals(jogador.getPosicao()) ? "selected" : "" %>>Atacante</option>
                </select></div>
            <div class="form-row"><label>Número</label>
                <input type="number" name="numero" value="<%= jogador != null ? jogador.getNumero() : 0 %>" required/></div>
            <div class="form-row"><label>Time</label>
                <select name="idTime" required>
                    <option value="">Selecione</option>
                    <% for (Time t : times) { %>
                        <option value="<%= t.getIdTime() %>" <%= jogador != null && jogador.getIdTime() == t.getIdTime() ? "selected" : "" %>><%= t.getNome() %></option>
                    <% } %>
                </select>
            </div>
        <% } %>
 
        <% if ("Estadio".equals(entidade)) { %>
            <div class="form-row"><label>Nome do Estádio</label>
                <input type="text" name="NomeEstadio" value="<%= estadio != null ? estadio.getNomeEstadio() : "" %>" required/></div>
            <div class="form-row"><label>Capacidade</label>
                <input type="number" name="Capacidade" value="<%= estadio != null ? estadio.getCapacidade() : 0 %>" required/></div>
            <div class="form-row"><label>Cidade</label>
                <input type="text" name="Cidade" value="<%= estadio != null ? estadio.getCidade() : "" %>"/></div>
        <% } %> 
        <% if ("Jogo".equals(entidade)) { %>
            <%
                String nomeCasa = "Casa";
                String nomeFora = "Visitante"; 
                if (jogo != null) {
                    for (Time t : times) {
                        if (t.getIdTime() == jogo.getIdTimeCasa()) nomeCasa = t.getNome();
                        if (t.getIdTime() == jogo.getIdTimeFora()) nomeFora = t.getNome();
                    }
                }
            %>
            <div class="form-row"><label>Time da Casa</label>
                <select name="idTimeCasa" required>
                    <option value="">Selecione</option>
                    <% for (Time t : times) { %>
                        <option value="<%= t.getIdTime() %>" <%= jogo != null && jogo.getIdTimeCasa() == t.getIdTime() ? "selected" : "" %>><%= t.getNome() %></option>
                    <% } %>
                </select></div>

            <div class="form-row"><label>Time Visitante</label>
                <select name="idTimeFora" required>
                    <option value="">Selecione</option>
                    <% for (Time t : times) { %>
                        <option value="<%= t.getIdTime() %>" <%= jogo != null && jogo.getIdTimeFora() == t.getIdTime() ? "selected" : "" %>><%= t.getNome() %></option>
                    <% } %>
                </select></div>

            <div class="form-row"><label>Estádio</label>
                <select name="idEstadio" required>
                    <option value="">Selecione</option>
                    <% for (Estadio e : estadios) { %>
                        <option value="<%= e.getIdEstadio() %>" <%= jogo != null && jogo.getIdEstadio() == e.getIdEstadio() ? "selected" : "" %>><%= e.getNomeEstadio() %></option>
                    <% } %>
                </select></div>

            <div class="form-row"><label>Horário</label>
                <input type="time" name="horario" value="<%= jogo != null ? jogo.getHorario() : "" %>" required/></div>

            <div class="form-row"><label>Gols <%= nomeCasa %></label>
                <input type="number" name="golsTimeCasa" value="<%= jogo != null ? jogo.getGolsTimeCasa() : 0 %>"/></div>

            <div class="form-row"><label>Gols <%= nomeFora %></label>
                <input type="number" name="golsTimeFora" value="<%= jogo != null ? jogo.getGolsTimeFora() : 0 %>"/></div>

            <% if (jogo != null) { %>
                <div class="form-row" style="margin-top:20px; border-top:1px solid #eee; padding-top:15px;">
                    <label>Adicionar Detalhes do Gol:</label>
                    <div style="display:flex; gap:10px;">
                        <a class="btn" style="flex:1; background-color:#06AA48;" 
                           href="Form.jsp?entidade=Gol&idJogo=<%= jogo.getIdJogo() %>&time=casa">
                           Gol do <%= nomeCasa %> (+)
                        </a>
                        
                        <a class="btn" style="flex:1; background-color:#0050d8;" 
                           href="Form.jsp?entidade=Gol&idJogo=<%= jogo.getIdJogo() %>&time=fora">
                           Gol do <%= nomeFora %> (+)
                        </a>
                    </div>
                </div>
            <% } else { %>
                <p style="color:#999; font-size:12px; text-align:center; margin-top:10px;">
                    (Salve o jogo primeiro para poder registrar quem fez os gols)
                </p>
            <% } %>

        <% } %>

        <% if ("Gol".equals(entidade)) { %>
            <%
                String idJogoParam = request.getParameter("idJogo");
                String timeSelecionado = request.getParameter("time"); 
                
                List<Jogador> jogadoresExibicao = new ArrayList<>();
                List<Jogador> todos = jogadorDao.listarTodos(); 
                 
                if (idJogoParam != null && !idJogoParam.isEmpty()) {
                    int idJ = Integer.parseInt(idJogoParam);
                    Jogo jAtual = jogoDao.buscarPorId(idJ);

                    if (jAtual != null) {
                        int idCasa = jAtual.getIdTimeCasa();
                        int idFora = jAtual.getIdTimeFora();
 
                        for (Jogador j : todos) { 
                            if ("casa".equals(timeSelecionado) && j.getIdTime() == idCasa) {
                                jogadoresExibicao.add(j);
                            } 
                            else if ("fora".equals(timeSelecionado) && j.getIdTime() == idFora) {
                                jogadoresExibicao.add(j);
                            } 
                            else if (timeSelecionado == null && (j.getIdTime() == idCasa || j.getIdTime() == idFora)) {
                                jogadoresExibicao.add(j);
                            }
                        }
                    }
                } else { 
                    jogadoresExibicao = todos;
                }
            %>

            <div class="form-row">
                <label>Jogador</label>
                <select name="idJogador" required>
                    <option value="">Selecione quem fez o gol</option>
                    <% for (Jogador jg : jogadoresExibicao) {  
                        String nomeTimeJog = "Time " + jg.getIdTime();
                        for(Time t : times) { if(t.getIdTime() == jg.getIdTime()) nomeTimeJog = t.getNome(); }
                    %>
                        <option value="<%= jg.getIdJogador() %>" 
                            <%= gol != null && gol.getIdJogador() == jg.getIdJogador() ? "selected" : "" %>>
                            <%= jg.getNome() %> - <%= nomeTimeJog %> (#<%= jg.getNumero() %>)
                        </option>
                    <% } %>
                </select>
            </div>

            <% if (idJogoParam != null) { %>
                <input type="hidden" name="idJogo" value="<%= idJogoParam %>"/>
                <div style="margin-bottom:15px; font-size:12px; color:#666; background:#f0f0f0; padding:5px; border-radius:4px;">
                    Vinculado ao Jogo ID: <strong><%= idJogoParam %></strong>
                </div>
            <% } else { %>
                <div class="form-row">
                    <label>Jogo</label>
                    <select name="idJogo" required>
                        <option value="">Selecione o Jogo</option>
                        <% for (Jogo gm : jogoDao.listarTodos()) { %>
                             <option value="<%= gm.getIdJogo() %>">Jogo #<%= gm.getIdJogo() %> (<%= gm.getHorario() %>)</option>
                        <% } %>
                    </select>
                </div>
            <% } %>

            <div class="form-row">
                <label>Minuto</label>
                <input type="number" name="minuto" value="<%= gol != null ? gol.getMinuto() : 0 %>" required placeholder="Ex: 45"/>
            </div>
            
        <% } %>
        <div class="actions">
            <button class="btn" type="submit">Salvar</button>
            <a href="Dashboard.jsp" class="btn" style="background-color:#999; margin-top:10px; display:block;">Cancelar / Voltar</a>
        </div>
    </form>
</div>
</body>
</html>