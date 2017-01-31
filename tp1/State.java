
public class State {
	/*
	 * pos donne la position de la voiture i dans sa ligne ou colonne (premiere
	 * case occupee par la voiture)
	 */
	public int[] pos;

	/*
	 * c,d et prev premettent de retracer l'etat precedent et le dernier
	 * mouvement effectue
	 */
	public int c;
	static private RushHour rh;
	public int d;
	public State prev;
	/*
	 * a utiliser dans la deuxieme partie, 
	 * n indique la distance entre l'eat
	 * actuel et l'etat initial, f le cout de l'etat actuel.
	 */
	public int n;
	public int f = 0;

	/*
	 * Contructeur d'un etat initial (& recebem qualquer valor = lixo)
	 */
	public State(int[] p, RushHour rh) {
		n = 0;
		int tam = p.length;
		pos = new int[tam];
		for (int i = 0; i < tam; i++)
			pos[i] = p[i];
		prev = null;
		State.rh = rh;
	}

	/*
	 * constructeur d'un etat a partir d'un etat s et d'un mouvement (c,d)
	 */
	public State(State s, int c, int d) {
		// TODO
		// garder les infos precedent
		this.prev = s;
		this.c = c;
		this.d = d;
		
		// copier les positions
		this.pos = new int[s.pos.length];
		for(int i = 0; i < s.pos.length; i++) {
			this.pos[i] = s.pos[i];
		}
		// mettre a jour les positions
		this.pos[c] += d;
	}


	// this est il final?
	public boolean success() {
		// TODO
		
		// true s'il faut juste faire +1 a la voiture rouge, sinon false
		return pos[0] >= 4;
	}

	/*
	 * Estimation du nombre de coup restants
	 */
	public int estimee1() {
		// TODO
		return 0;
	}

	public int estimee2() {
		// TODO
		return 0;
	}

	@Override
	public boolean equals(Object o) {
		State s = (State) o;
		if (s.pos.length != pos.length) {
			System.out.println("les etats n'ont pas le meme nombre de voitures");
		}
		int tamanho = pos.length;

		for (int i = 0; i < tamanho; i++)
			if (pos[i] != s.pos[i])
				return false;
		return true;
	}

	@Override
	public int hashCode() {
		int h = 0;
		for (int i = 0; i < pos.length; i++)
			h = 37 * h + pos[i];
		return h;
	}

	
}
