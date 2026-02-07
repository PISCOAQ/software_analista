class DomandaTest {
  final int indice;
  final bool superata;
  final double tempoReazione; // ms

  DomandaTest({
    required this.indice,
    required this.superata,
    required this.tempoReazione,
  });

  factory DomandaTest.fromJson(Map<String, dynamic> json) {
    return DomandaTest(
      indice: json['indice'],
      superata: json['superata'],
      tempoReazione: (json['tempoReazione'] as num).toDouble(),
    );
  }
}
