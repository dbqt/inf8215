import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Queue;

public class RushHour {

	/*
	 * representation du probleme : Les six lignes sont numerotees de haut en
	 * bas, de 0 a 5 et les 6 colonnes de gauche a droite, de 0 a 5.
	 *
	 * il y a nbcars voitures, numerotees de 0 a nbcars-1 pour chaque voiture i
	 * on a : - color[i] sa couleur - horiz[i] si la voiture est horizontale
	 * (vrai) ou verticale (faux) - len[i] sa longueur (2 ou 3) - moveon[i] la
	 * ligne (si horiz[i]) ou la colonne (sinon) ou se trouve la voiture
	 *
	 */

	public int nbcars;
	public String[] color;
	public boolean[] horiz;
	public int[] len;
	public int[] moveon;

	public int nbMoves;
	/*
	 * la matrice free permet de savoir si une case est libre
	 */
	public boolean[][] free = new boolean[6][6];

	void initFree(State s) {
		//TODO
		// fill with true
		for(int i = 0; i < 6; i++) {
			for(int j = 0; j < 6; j++) {
				free[i][j] = true;
			}
		}
		
		//for each voiture
		for(int voiture = 0; voiture < nbcars; voiture++){
			if(horiz[voiture]){ //moves only horizontal
				int i = s.pos[voiture];
				int j = moveon[voiture];
				// fill space taken with false
				for(int c = 0; c < len[voiture]; c++) {
					free[j][i+c] = false;
				}
			} 
			else { //moves only vertical
				int i = moveon[voiture];
				int j = s.pos[voiture];
				// fill space taken with false
				for(int c = 0; c < len[voiture]; c++) {
					free[j+c][i] = false;
				}
			}
		}
	}

	/*
	 * renvoie la liste des deplacements possibles
	 */

	public ArrayList<State> moves(State s) {
		initFree(s);
		ArrayList<State> l = new ArrayList<State>();
		//TODO
		// for each voiture
		for(int c = 0; c < nbcars; c++) {
			// get position & length
			int i = moveon[c];
			int j = s.pos[c];
			int clen = len[c] - 1;
			
			if(horiz[c]){
				// peut-on reculer
				if(i > 0 && free[j][i-1]) {
					l.add(new State(s, c, -1));
				}
				// peut-on avancer
				if(i < (5-clen) &&free[j][i+clen+1]) {
					l.add(new State(s, c, 1));
				}
			}
			else {
				// peut-on reculer
				if(j > 0 && free[j-1][i]) {
					l.add(new State(s, c, -1));
				}
				// peut-on avancer
				if(j < (5-clen) &&free[j+clen+1][i]) {
					l.add(new State(s, c, 1));
				}
			}
		}
		return l;
	}

	/*
	 * trouve une solution a partir de s
	 */
	public State solve(State s) {
		HashSet<State> visited = new HashSet<State>();
		visited.add(s);
		Queue<State> Q = new LinkedList<State>();
		//TODO
		System.out.println("pas de solution");
		return null;
	}

	public State solveAstar(State s) {
		HashSet<State> visited = new HashSet<State>();
		visited.add(s);
		PriorityQueue<State> Q = new PriorityQueue<State>(10, new MyComparator());
		//TODO
		System.out.println("pas de solution");
		return null;
	}

	/*
	 * affiche la solution
	 */

	void printSolution(State s) {
		// TODO
	}
	
	private class MyComparator implements Comparator<State> {
		@Override
		public int compare(State arg0, State arg1) {
			return arg0.f - arg1.f;
		}
	}
}
