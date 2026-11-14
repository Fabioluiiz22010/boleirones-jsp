<%@ page import="model.Time" %>
<%@ page import="model.Jogador" %>
<%@ page import="model.Estadio" %>
<%@ page import="model.Jogo" %>
<%@ page import="model.Gol" %>
<%@ page import="dao.TimeDAO" %>
<%@ page import="dao.JogadorDAO" %>
<%@ page import="dao.EstadioDAO" %>
<%@ page import="dao.JogoDAO" %>
<%@ page import="dao.GolDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String entidade = request.getParameter("entidade");
    String idParam = request.getParameter("id");
    int id = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;

    if ("Time".equals(entidade)) {
        String nome = request.getParameter("nome");
        String cidade = request.getParameter("cidade");
        Time t = new Time();
        t.setNome(nome);
        t.setCidade(cidade);
        if (id != 0) { t.setIdTime(id); new TimeDAO().atualizar(t); }
        else { new TimeDAO().inserir(t); 
        response.sendRedirect("Form.jsp?entidade=Jogador&idTime=" + t.getIdTime());
        return;
        }
    } else if ("Jogador".equals(entidade)) {
        String nome = request.getParameter("nome");
        String pos = request.getParameter("posicao");
        int numero = Integer.parseInt(request.getParameter("numero"));
        int idTime = Integer.parseInt(request.getParameter("idTime"));
        Jogador j = new Jogador();
        j.setNome(nome); j.setPosicao(pos); j.setNumero(numero); j.setIdTime(idTime);
        if (id != 0) { j.setIdJogador(id); new JogadorDAO().atualizar(j); } else new JogadorDAO().inserir(j);
        response.sendRedirect("Form.jsp?entidade=Jogador&idTime=" + idTime);
        return;
    } else if ("Estadio".equals(entidade)) {
        String nomeE = request.getParameter("NomeEstadio");
        int cap = Integer.parseInt(request.getParameter("Capacidade"));
        String cidade = request.getParameter("Cidade");
        Estadio e = new Estadio();
        e.setNomeEstadio(nomeE); e.setCapacidade(cap); e.setCidade(cidade);
        if (id != 0) { e.setIdEstadio(id); new EstadioDAO().atualizar(e); } else new EstadioDAO().inserir(e);
    }else if ("Jogo".equals(entidade)) {
        int idTimeCasa = Integer.parseInt(request.getParameter("idTimeCasa"));
        int idTimeFora = Integer.parseInt(request.getParameter("idTimeFora"));
        int golsCasa = Integer.parseInt(request.getParameter("golsTimeCasa"));
        int golsFora = Integer.parseInt(request.getParameter("golsTimeFora"));
        int idEstadio = Integer.parseInt(request.getParameter("idEstadio"));
        String horario = request.getParameter("horario");

        Jogo j = new Jogo();
        j.setIdTimeCasa(idTimeCasa);
        j.setIdTimeFora(idTimeFora);
        j.setGolsTimeCasa(golsCasa);
        j.setGolsTimeFora(golsFora);
        j.setIdEstadio(idEstadio);
        j.setHorario(horario);

        JogoDAO jd = new JogoDAO();
        if (id != 0) {
            j.setIdJogo(id);
            jd.atualizar(j);
        } else {
            jd.inserir(j); //aqui o objeto j já recebe o id gerado automaticamente
        }

        //redirecionamento condicional
        if (golsCasa == 0 && golsFora == 0) {
            response.sendRedirect("Dashboard.jsp"); // zero a zero vai para dashboard
        } else {
            //passa o id do jogo recém-criado para o form de Gol
            response.sendRedirect("Form.jsp?entidade=Gol&idJogo=" + j.getIdJogo());
        }
        return;
    }

    else if ("Gol".equals(entidade)) {
        int idJogo = Integer.parseInt(request.getParameter("idJogo"));
        int minuto = Integer.parseInt(request.getParameter("minuto"));
        int idJogador = Integer.parseInt(request.getParameter("idJogador"));

        JogoDAO jd = new JogoDAO();
        Jogo j = jd.buscarPorId(idJogo);

        Gol g = new Gol();
        g.setIdJogador(idJogador);
        g.setIdJogo(idJogo);
        g.setMinuto(minuto);

        GolDAO gdao = new GolDAO();
        JogadorDAO jogadorDAO = new JogadorDAO();

        if (id != 0) {
            g.setIdGol(id);
            gdao.atualizar(g);
           
        } else {
            gdao.inserir(g);
            //atualiza o total de gols do jogador
            jogadorDAO.adicionarGol(idJogador);
        }

        //conta quantos gols já foram cadastrados
        int golsCadastradosCasa = gdao.contarGolsPorJogoETime(idJogo, j.getIdTimeCasa());
        int golsCadastradosFora = gdao.contarGolsPorJogoETime(idJogo, j.getIdTimeFora());
 
        if (golsCadastradosCasa < j.getGolsTimeCasa()) {
             
            response.sendRedirect("Form.jsp?entidade=Gol&idJogo=" + idJogo + "&time=casa");
        } else if (golsCadastradosFora < j.getGolsTimeFora()) {
            //cadastrar gols do visitante
            response.sendRedirect("Form.jsp?entidade=Gol&idJogo=" + idJogo + "&time=fora");
        } else {
            //todos os gols cadastrados, volta pro dash  
            response.sendRedirect("Dashboard.jsp");
        }
        return;
    }


%>
