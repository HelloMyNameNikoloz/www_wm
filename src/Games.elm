module Games exposing (Game, games)


type alias Game =
    { number : Int
    , date : String
    , time : String
    , stage : String
    , home : String
    , away : String
    , score : String
    }


game : Int -> String -> String -> String -> String -> String -> String -> Game
game number date time stage home away score =
    { number = number
    , date = date
    , time = time
    , stage = stage
    , home = home
    , away = away
    , score = score
    }


games : List Game
games =
    [ game 1 "11.06.2026" "21:00" "Gruppe A" "Mexiko" "Südafrika" "2:0"
    , game 2 "12.06.2026" "04:00" "Gruppe A" "Südkorea" "Tschechien" "2:1"
    , game 3 "12.06.2026" "21:00" "Gruppe B" "Kanada" "Bosnien und Herzegowina" "1:1"
    , game 4 "13.06.2026" "03:00" "Gruppe D" "USA" "Paraguay" "4:1"
    , game 8 "13.06.2026" "21:00" "Gruppe B" "Katar" "Schweiz" "1:1"
    , game 7 "14.06.2026" "00:00" "Gruppe C" "Brasilien" "Marokko" "1:1"
    , game 5 "14.06.2026" "03:00" "Gruppe C" "Haiti" "Schottland" "0:1"
    , game 6 "14.06.2026" "06:00" "Gruppe D" "Australien" "Türkei" "2:0"
    , game 10 "14.06.2026" "19:00" "Gruppe E" "Deutschland" "Curaçao" "7:1"
    , game 11 "14.06.2026" "22:00" "Gruppe F" "Niederlande" "Japan" "2:2"
    , game 9 "15.06.2026" "01:00" "Gruppe E" "Elfenbeinküste" "Ecuador" "1:0"
    , game 12 "15.06.2026" "04:00" "Gruppe F" "Schweden" "Tunesien" "5:1"
    , game 14 "15.06.2026" "18:00" "Gruppe H" "Spanien" "Kap Verde" "0:0"
    , game 16 "15.06.2026" "21:00" "Gruppe G" "Belgien" "Ägypten" "1:1"
    , game 13 "16.06.2026" "00:00" "Gruppe H" "Saudi-Arabien" "Uruguay" "1:1"
    , game 15 "16.06.2026" "03:00" "Gruppe G" "Iran" "Neuseeland" "2:2"
    , game 17 "16.06.2026" "21:00" "Gruppe I" "Frankreich" "Senegal" "3:1"
    , game 18 "17.06.2026" "00:00" "Gruppe I" "Irak" "Norwegen" "1:4"
    , game 19 "17.06.2026" "03:00" "Gruppe J" "Argentinien" "Algerien" "3:0"
    , game 20 "17.06.2026" "06:00" "Gruppe J" "Österreich" "Jordanien" "3:1"
    , game 23 "17.06.2026" "19:00" "Gruppe K" "Portugal" "DR Kongo" "1:1"
    , game 22 "17.06.2026" "22:00" "Gruppe L" "England" "Kroatien" "4:2"
    , game 21 "18.06.2026" "01:00" "Gruppe L" "Ghana" "Panama" "1:0"
    , game 24 "18.06.2026" "04:00" "Gruppe K" "Usbekistan" "Kolumbien" "1:3"
    , game 25 "18.06.2026" "18:00" "Gruppe A" "Tschechien" "Südafrika" "1:1"
    , game 26 "18.06.2026" "21:00" "Gruppe B" "Schweiz" "Bosnien und Herzegowina" "4:1"
    , game 27 "19.06.2026" "00:00" "Gruppe B" "Kanada" "Katar" "6:0"
    , game 28 "19.06.2026" "03:00" "Gruppe A" "Mexiko" "Südkorea" "1:0"
    , game 32 "19.06.2026" "21:00" "Gruppe D" "USA" "Australien" "2:0"
    , game 30 "20.06.2026" "00:00" "Gruppe C" "Schottland" "Marokko" "0:1"
    , game 29 "20.06.2026" "02:30" "Gruppe C" "Brasilien" "Haiti" "3:0"
    , game 31 "20.06.2026" "05:00" "Gruppe D" "Türkei" "Paraguay" "0:1"
    , game 35 "20.06.2026" "19:00" "Gruppe F" "Niederlande" "Schweden" "5:1"
    , game 33 "20.06.2026" "22:00" "Gruppe E" "Deutschland" "Elfenbeinküste" "2:1"
    , game 34 "21.06.2026" "02:00" "Gruppe E" "Ecuador" "Curaçao" "0:0"
    , game 36 "21.06.2026" "06:00" "Gruppe F" "Tunesien" "Japan" "0:4"
    , game 38 "21.06.2026" "18:00" "Gruppe H" "Spanien" "Saudi-Arabien" "4:0"
    , game 39 "21.06.2026" "21:00" "Gruppe G" "Belgien" "Iran" "0:0"
    , game 37 "22.06.2026" "00:00" "Gruppe H" "Uruguay" "Kap Verde" "2:2"
    , game 40 "22.06.2026" "03:00" "Gruppe G" "Neuseeland" "Ägypten" "1:3"
    , game 43 "22.06.2026" "19:00" "Gruppe J" "Argentinien" "Österreich" "2:0"
    , game 42 "22.06.2026" "23:00" "Gruppe I" "Frankreich" "Irak" "3:0"
    , game 41 "23.06.2026" "02:00" "Gruppe I" "Norwegen" "Senegal" "3:2"
    , game 44 "23.06.2026" "05:00" "Gruppe J" "Jordanien" "Algerien" "1:2"
    , game 47 "23.06.2026" "19:00" "Gruppe K" "Portugal" "Usbekistan" "5:0"
    , game 45 "23.06.2026" "22:00" "Gruppe L" "England" "Ghana" "0:0"
    , game 46 "24.06.2026" "01:00" "Gruppe L" "Panama" "Kroatien" "0:1"
    , game 48 "24.06.2026" "04:00" "Gruppe K" "Kolumbien" "DR Kongo" "1:0"
    , game 51 "24.06.2026" "21:00" "Gruppe B" "Schweiz" "Kanada" "2:1"
    , game 52 "24.06.2026" "21:00" "Gruppe B" "Bosnien und Herzegowina" "Katar" "3:1"
    , game 49 "25.06.2026" "00:00" "Gruppe C" "Schottland" "Brasilien" "0:3"
    , game 50 "25.06.2026" "00:00" "Gruppe C" "Marokko" "Haiti" "4:2"
    , game 53 "25.06.2026" "03:00" "Gruppe A" "Tschechien" "Mexiko" "0:3"
    , game 54 "25.06.2026" "03:00" "Gruppe A" "Südafrika" "Südkorea" "1:0"
    , game 55 "25.06.2026" "22:00" "Gruppe E" "Curaçao" "Elfenbeinküste" "0:2"
    , game 56 "25.06.2026" "22:00" "Gruppe E" "Ecuador" "Deutschland" "2:1"
    , game 57 "26.06.2026" "01:00" "Gruppe F" "Japan" "Schweden" "1:1"
    , game 58 "26.06.2026" "01:00" "Gruppe F" "Tunesien" "Niederlande" "1:3"
    , game 59 "26.06.2026" "04:00" "Gruppe D" "Türkei" "USA" "3:2"
    , game 60 "26.06.2026" "04:00" "Gruppe D" "Paraguay" "Australien" "0:0"
    , game 61 "26.06.2026" "21:00" "Gruppe I" "Norwegen" "Frankreich" "1:4"
    , game 62 "26.06.2026" "21:00" "Gruppe I" "Senegal" "Irak" "5:0"
    , game 65 "27.06.2026" "02:00" "Gruppe H" "Kap Verde" "Saudi-Arabien" "0:0"
    , game 66 "27.06.2026" "02:00" "Gruppe H" "Uruguay" "Spanien" "0:1"
    , game 63 "27.06.2026" "05:00" "Gruppe G" "Ägypten" "Iran" "1:1"
    , game 64 "27.06.2026" "05:00" "Gruppe G" "Neuseeland" "Belgien" "1:5"
    , game 67 "27.06.2026" "23:00" "Gruppe L" "Panama" "England" "0:2"
    , game 68 "27.06.2026" "23:00" "Gruppe L" "Kroatien" "Ghana" "2:1"
    , game 71 "28.06.2026" "01:30" "Gruppe K" "Kolumbien" "Portugal" "0:0"
    , game 72 "28.06.2026" "01:30" "Gruppe K" "DR Kongo" "Usbekistan" "3:1"
    , game 69 "28.06.2026" "04:00" "Gruppe J" "Algerien" "Österreich" "3:3"
    , game 70 "28.06.2026" "04:00" "Gruppe J" "Jordanien" "Argentinien" "1:3"
    , game 73 "28.06.2026" "21:00" "Sechzehntelfinale" "Südafrika" "Kanada" "0:1"
    , game 76 "29.06.2026" "19:00" "Sechzehntelfinale" "Brasilien" "Japan" "2:1"
    , game 74 "29.06.2026" "22:30" "Sechzehntelfinale" "Deutschland" "Paraguay" "1:1 (3:4 i.E.)"
    , game 75 "30.06.2026" "03:00" "Sechzehntelfinale" "Niederlande" "Marokko" "1:1 (2:3 i.E.)"
    , game 78 "30.06.2026" "19:00" "Sechzehntelfinale" "Elfenbeinküste" "Norwegen" "1:2"
    , game 77 "30.06.2026" "23:00" "Sechzehntelfinale" "Frankreich" "Schweden" "3:0"
    , game 79 "01.07.2026" "04:00" "Sechzehntelfinale" "Mexiko" "Ecuador" "2:0"
    , game 80 "01.07.2026" "18:00" "Sechzehntelfinale" "England" "DR Kongo" "2:1"
    , game 82 "01.07.2026" "22:00" "Sechzehntelfinale" "Belgien" "Senegal" "3:2"
    , game 81 "02.07.2026" "02:00" "Sechzehntelfinale" "USA" "Bosnien und Herzegowina" "2:0"
    , game 84 "02.07.2026" "21:00" "Sechzehntelfinale" "Spanien" "Österreich" "3:0"
    , game 83 "03.07.2026" "01:00" "Sechzehntelfinale" "Portugal" "Kroatien" "2:1"
    , game 85 "03.07.2026" "05:00" "Sechzehntelfinale" "Schweiz" "Algerien" "2:0"
    , game 88 "03.07.2026" "20:00" "Sechzehntelfinale" "Australien" "Ägypten" "1:1 (2:4 i.E.)"
    , game 86 "04.07.2026" "00:00" "Sechzehntelfinale" "Argentinien" "Kap Verde" "3:2"
    , game 87 "04.07.2026" "03:30" "Sechzehntelfinale" "Kolumbien" "Ghana" "1:0"
    , game 90 "04.07.2026" "19:00" "Achtelfinale" "Kanada" "Marokko" "0:3"
    , game 89 "04.07.2026" "23:00" "Achtelfinale" "Paraguay" "Frankreich" "0:1"
    , game 91 "05.07.2026" "22:00" "Achtelfinale" "Brasilien" "Norwegen" "1:2"
    , game 92 "06.07.2026" "03:00" "Achtelfinale" "Mexiko" "England" "2:3"
    , game 93 "06.07.2026" "21:00" "Achtelfinale" "Portugal" "Spanien" "0:1"
    , game 94 "07.07.2026" "02:00" "Achtelfinale" "USA" "Belgien" "1:4"
    , game 95 "07.07.2026" "18:00" "Achtelfinale" "Argentinien" "Ägypten" "3:2"
    , game 96 "07.07.2026" "22:00" "Achtelfinale" "Schweiz" "Kolumbien" "0:0 (4:3 i.E.)"
    , game 97 "09.07.2026" "22:00" "Viertelfinale" "Frankreich" "Marokko" "2:0"
    , game 98 "10.07.2026" "21:00" "Viertelfinale" "Spanien" "Belgien" "2:1"
    , game 99 "11.07.2026" "23:00" "Viertelfinale" "Norwegen" "England" "1:2"
    , game 100 "12.07.2026" "03:00" "Viertelfinale" "Argentinien" "Schweiz" "3:1"
    , game 101 "14.07.2026" "21:00" "Halbfinale" "Frankreich" "Spanien" "0:2"
    , game 102 "15.07.2026" "21:00" "Halbfinale" "England" "Argentinien" "-"
    , game 103 "18.07.2026" "23:00" "Spiel um Platz 3" "Frankreich" "Verlierer Halbfinale 2" "-"
    , game 104 "19.07.2026" "21:00" "Finale" "Spanien" "Sieger Halbfinale 2" "-"
    ]
