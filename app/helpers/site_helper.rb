module SiteHelper
    def msg_jumbotron
        case params[:action]
        when 'index'
            "Últimas Perguntas Cadastradas:"
        when 'questions'
            "Resultados para o termo \"#{params[:term]}\"..."
        when 'subject'
            "Questões referentes ao Assunto : \"#{params[:subject]}\"..."
        end
    end
end
