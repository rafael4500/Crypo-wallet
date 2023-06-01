namespace :dev do
  desc "Configurando o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      
      show_spinner("Apagando DB...") {%x(rails db:drop)}
      show_spinner("Criando DB...") {%x(rails db:create)}
      show_spinner("Migrando DB...") {%x(rails db:migrate)}
      %x(rails dev:add_coins)
      %x(rails dev:add_mining_type) 

    else 
     puts "Voce nao esta em modo de desenvolvimente !"
    end
  end

desc "cadastro de moedas"
task add_coins: :environment do
  show_spinner("Cadastrando moedas...") do
    coins = [
        {
            description: "Bircoin",
            acronym:"BTC",
            url_image: "https://static.vecteezy.com/system/resources/thumbnails/008/505/801/small_2x/bitcoin-logo-color-illustration-png.png",
            mining_type: MiningType.all.sample
        },

        {
            description: "Dolar",
            acronym: "USD",
            url_image: "https://e7.pngegg.com/pngimages/557/702/png-clipart-dollar-dollar.png",
            mining_type: MiningType.all.sample
        },

        {
            description: "Real",
            acronym: "BRL",
            url_image: "https://cdn-icons-png.flaticon.com/512/32/32665.png",
            mining_type: MiningType.all.sample
        }
    ]

    coins.each do |coin|
        Coin.find_or_create_by!(coin)
        sleep(1)
      end
    end
  end

  desc "cadastra os tipo de mineracao"
    task add_mining_type: :environment do
    show_spinner("Cadastrando tipos de mineracao") do
    mining_type = [
      {description:"Proof of Work", acronym:"PoW"},
      {description:"Proof of Stake", acronym:"PoS"},
      {description:"Proof of Capacity", acronym:"PoC"}
    ]

      mining_type.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  
  private

  def show_spinner(msg_start, msg_end = 'Concluido')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end

