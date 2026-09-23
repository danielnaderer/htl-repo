import java.util.Objects;

public class Kandidat {

    private final String name;
    private final char kuerzel;

    private int punkte;
    private int erstePlaetze;

    public Kandidat(String name, char kuerzel) {
        this.name = name;
        this.kuerzel = Character.toLowerCase(kuerzel);
    }

    public void addPoints(int points) {
        if (points < 0) {
            throw new IllegalArgumentException("Punkte dürfen nicht negativ sein.");
        }

        punkte += points;

        if (points == 2) {
            erstePlaetze++;
        }
    }

    public boolean hasKuerzel(char kuerzel) {
        return this.kuerzel == Character.toLowerCase(kuerzel);
    }

    public int getPunkte() {
        return punkte;
    }

    public int getErstePlaetze() {
        return erstePlaetze;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return "%04d / %04d   %s".formatted(
                punkte,
                erstePlaetze,
                name
        );
    }

    @Override
    public boolean equals(Object object) {
        if (this == object) return true;
        if (!(object instanceof Kandidat kandidat)) return false;

        return kuerzel == kandidat.kuerzel
                && Objects.equals(name, kandidat.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, kuerzel);
    }
}