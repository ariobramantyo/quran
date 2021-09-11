class BookmarkVerse {
  int? id;
  final String surahName;
  final int numberInQuran;
  final int surahNumber;
  final int numberOfVerseBookmarked;

  BookmarkVerse({
    this.id,
    required this.numberInQuran,
    required this.surahName,
    required this.surahNumber,
    required this.numberOfVerseBookmarked,
  });

  factory BookmarkVerse.fromMap(Map<String, dynamic> map) {
    return BookmarkVerse(
        id: map['id'],
        surahName: map['surahName'],
        numberInQuran: map['numberInQuran'],
        surahNumber: map['surahNumber'],
        numberOfVerseBookmarked: map['numberOfVerseBookmarked']);
  }

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'surahName': this.surahName,
        'numberInQuran': this.numberInQuran,
        'surahNumber': this.surahNumber,
        'numberOfVerseBookmarked': this.numberOfVerseBookmarked,
      };
}
