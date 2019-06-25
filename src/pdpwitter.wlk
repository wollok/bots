class Imagen {
	var nombre
	var tamanio

}

class Tweet {
	var texto
	var imagen
	var usuario

	method texto(){
		return texto;
	}
	method usuario(){
		return usuario;
	}
	method contiene(palabra){
		return texto.contains(palabra)
	}
	method esDemasiadoLargo(){
		return texto.size() > 15
	}
	
	method esALaNada(){
		return !texto.any({palabra => palabra.startsWith("@")})
	}
}

object pdpwitter { 
	var tweets = []
	var bots = [benito, 
		new BotPublicitario('comida', 'www.google.com', 'soloEmpanadas', new Imagen('hola', 120) )
		]	
	method recibirTweet(tweet){
		if(tweet.esDemasiadoLargo()){
			error.throwWithMessage("Tweet demasiado largo")
		}
		tweets.add(tweet)
		self.botsParaResponder(tweet).forEach({ bot => bot.responder(tweet)})
	}
	
	method tweets(){
		return tweets;
	}
	method agregarBot(bot){
		bots.add(bot)
	}
	
	method botsParaResponder(tweet){
		return bots.filter({bot=>bot.cumpleCondiciones(tweet)})
	}
	method tweetsParaUsuario(usuario){
		return tweets.filter({tweet => tweet.contiene("@" + usuario)})	
	}	
	
	method tweetsALaNada(){
		return tweets.filter({ tweet=> tweet.esALaNada() })
	}
}

object policia {
	var tweetsIlegales = []
	method guardarTweet(tweet){
		tweetsIlegales.add(tweet)
	}
}

object benito {	
	const palabras = ['droga', 'falopa']
	method cumpleCondiciones(tweet){
		return palabras.any({ palabra => tweet.contiene(palabra) })
	}
	method responder(tweet){
		policia.guardarTweet(tweet)			
	}
}

class BotPublicitario {
	var palabra
	var link
	var nombre
	var imagen
	
	method cumpleCondiciones(tweet){
		return tweet.contiene(palabra)
	}
	method responder(tweet){
		pdpwitter.recibirTweet(new Tweet(['@' + tweet.usuario(), link], imagen, nombre))	
	}
}


class BotAnalista {
	var tweets = []
	method cumpleCondiciones(tweet){
		return true
	}
	method responder(tweet){
		tweets.add(tweet)
	}
	method tweets(){
		return tweets
	}
}
