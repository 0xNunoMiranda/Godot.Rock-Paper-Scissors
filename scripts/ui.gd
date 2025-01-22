extends Control

# Exportando Labels que serão atribuídos no editor
@export var player_points_label: Label 
@export var opponent_points_label: Label 
@export var result: Label 
@export var opponent_result: Label 

# Variáveis para armazenar os pontos do jogador e do oponente
var player_points: int = 0 
var opponent_points: int = 0

# Chamado quando o nó entra na árvore da cena pela primeira vez.
func _ready():
	result.text = "Start Game"
	opponent_result.text = ""

# Função chamada quando o botão é pressionado
func _on_button_pressed(player_choice: String) -> void:
	$AnimationPlayer.play("RESET")
	var opponent_choices: String = ""
	# Gera um número aleatório para a escolha do oponente
	var number: int = randi_range(1, 3)
	match number:
		1:
			opponent_choices = "Rock"
			$SpriteContainer/EnemySprite.frame = 0
		2:
			opponent_choices = "Scissors"
			$SpriteContainer/EnemySprite.frame = 1
		_:
			opponent_choices = "Paper"
			$SpriteContainer/EnemySprite.frame = 2
			
	# Atualiza a sprite do jogador com base na escolha
	match player_choice:
		"Rock":
			$SpriteContainer/PlayerSprite.frame = 0
		"Scissors":
			$SpriteContainer/PlayerSprite.frame = 1
		"Paper":
			$SpriteContainer/PlayerSprite.frame = 2
	# Verifica o resultado do jogo
	check_result(opponent_choices, player_choice)

# Verifica o resultado do jogo e atualiza os pontos e labels
func check_result(opponent_choices: String, player_choice: String) -> void:
	if(opponent_choices == player_choice):
		result.text = "DRAW"
	elif(
		opponent_choices == "Paper" and 
		player_choice == "Scissors"
	):
		result.text = "YOU WIN"
		player_points += 1
	elif(
		opponent_choices == "Rock" and 
		player_choice == "Paper"
	):
		result.text = "YOU WIN"
		player_points += 1
	elif(
		opponent_choices == "Scissors" and 
		player_choice == "Rock"
	):
		result.text = "YOU WIN"
		player_points += 1
	else:
		result.text = "YOU LOSE"
		opponent_points += 1
	$AnimationPlayer.play("show_result")
	opponent_result.text = opponent_choices
	player_points_label.text = str(player_points)
	opponent_points_label.text = str(opponent_points)
