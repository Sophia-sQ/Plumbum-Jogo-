extends Control

@onready var pluto_em_pe: CharacterBody2D = $"../../../../pluto_em_pe"
@onready var pergunta: Label = $Sprite2D/pergunta
@onready var a: Button = $Sprite2D/a
@onready var b: Button = $Sprite2D/b
@onready var c: Button = $Sprite2D/c
@onready var fechar: TextureButton = $Sprite2D/fechar
signal certo
@export var resposta: String
var bau
func _ready() -> void:
	visible=false
	bau=get_parent()
	
func _process(delta: float) -> void:
	pass

func _chamado(bau: int):
	pluto_em_pe.anda=false
	visible=true
	_enabled()
	if bau==1:
		_texto("O que é a camada de valência de uma átomo?", 
				"a. Camada com mais elétrons", 
				"b. Camada mais externa",
				"c. Camada com mais nêutrons")
	elif bau==2:
		_texto("Sabendo que o Plumbum é um elemento em latim e que tem número atômico 82. Qual desses elementos é Plumbum?", 
				"a. O protagonista  Z = 733.423.413-95(5) A = 65kg",
				"b. Polônio Z = 84 A = 209",
				"c. Chumbo Z = 82 A = 207")
	else: #bau==3:
		_texto("Se Radonio está no período 6 e no bloco p da tabela períodica, qual é a sua camada mais externa com elétrons?", 
				"a. 1s",
				"b. p66",
				"c. 6p")
	
func _texto(questao: String, resA:String, resB: String, resC: String):
	pergunta.text=questao
	a.text=resA
	b.text=resB
	c.text=resC
	
func _on_fechar_pressed() -> void:
	visible=false
	#get_tree().paused=false
	pluto_em_pe.anda=true
	
func _on_a_pressed() -> void:
	if resposta=="a":
		_correto()
	else:
		_errado()

func _on_b_pressed() -> void:
	if resposta=="b":
		_correto()
	else:
		_errado()

func _on_c_pressed() -> void:
	if resposta=="c":
		_correto()
	else:
		_errado()
		
func _errado():
	_disabled()
	pergunta.text="Feche (X) e tente novamente."
	a.text="a. errado"
	b.text="b. errado"
	c.text="c. errado"

func _correto():
	_texto("Correto. A tela fechará automaticamente.", "a. correto", "b. correto", "c. correto")
	_disabled()
	fechar.disabled=true
	await get_tree().create_timer(3.5).timeout
	queue_free()
	pluto_em_pe.anda=true
	#get_tree().paused=false
	certo.emit()

func _disabled():
	a.disabled=true
	b.disabled=true
	c.disabled=true

func _enabled():
	a.disabled=false
	b.disabled=false
	c.disabled=false
	fechar.disabled=false
	
