module ApplicationHelper
    def locale
        I18n.locale == :en ? "Estados unidos" : "Portugues Brasil"
    end
    def data_br(data_us)
        data_us.strftime('%d/%m/%y')
    end

    def ambiente_Rails
        if Rails.env.development?
            "Desenvolvimento"
        elsif Rails.env.production?
            "Producao"
        else 
            "teste"
        end
    end

end
