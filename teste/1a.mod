/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Asus
 * Creation Date: 01/12/2018 at 23:16:25
 *********************************************/
 
 
//Par�metros sobre a dimens�o do problema
int n = 7;
int a[i in 1..n] = i;

//In�cio ou fim do fogo
int i_inicio = 1;
int j_inicio = 1;


//Par�metros sobre os custos dos arcos
int Cima [1..n][1..n] = ...;
int Direita [1..n][1..n] = ...;
int Baixo [1..n][1..n] = ...;
int Esquerda [1..n][1..n] = ...;
int Custos[1..n][1..n][1..n][1..n]; 			//Matriz contendo todos os arcos

//C�digo para preencher a matriz dos custos a partir das outras (extra�das da folha excel)
execute {
for(var x in a)
	for(var xx in a)
		for(var xxx in a)
			for(var xxxx in a)
				Custos[x][xx][xxx][xxxx] = 9999;

  for(var i in a) {
  	for(var j in a) {
		if(i > 1)  	
  	  	  	Custos[i][j][i - 1][j] = Cima[i][j];
  	  	if(i < n)  	
  	  	  	Custos[i][j][i + 1][j] = Baixo[i][j];
  	  	if(j > 1)  	
  	  	  	Custos[i][j][i][j - 1] = Esquerda[i][j];
  	  	if(j < n)  	
  	  	  	Custos[i][j][i][j + 1] = Direita[i][j];  	  	  
  	}  
  }}


//Vari�veis de Decis�o
 dvar float+ X[1..n][1..n][1..n][1..n];			//N�mero de caminhos em que o arco ijkl � utilizado
 
 //Fun��o Objetivo
 minimize sum(i in 1..n, j in 1..n, k in 1..n, l in 1..n)  Custos[i][j][k][l]*X[i][j][k][l];
  
 //Restri��es
 subject to{
 	sum(i in 1..n, j in 1..n) (X[i_inicio][j_inicio][i][j] - X[i][j][i_inicio][j_inicio]) == n^2 -1; 											//Do nodo 1,1 saem 48 caminhos
 	forall(i in 1..n, j in 1..n: i != 1 || j != 1) (sum(k in 1..n, l in 1..n) (X[i][j][k][l] - X[k][l][i][j]) >= -1); 						//De um nodo sai menos um caminho do que a ele chegam (visto que o caminho mais curto para esse nodo termina nele)
}