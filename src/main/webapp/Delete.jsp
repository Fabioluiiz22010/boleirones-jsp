<%@ page import="dao.*" %>
<%
    String entidade = request.getParameter("entidade");
    String idParam = request.getParameter("id");
    if (entidade != null && idParam != null) {
        int id = Integer.parseInt(idParam);
        if ("Time".equals(entidade)) new TimeDAO().deletar(id);
        if ("Jogador".equals(entidade)) new JogadorDAO().deletar(id);
        if ("Estadio".equals(entidade)) new EstadioDAO().deletar(id);
        if ("Jogo".equals(entidade)) new JogoDAO().deletar(id);
        if ("Gol".equals(entidade)) new GolDAO().deletar(id);
    }
    response.sendRedirect("Dashboard.jsp");
%>
