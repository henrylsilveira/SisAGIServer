-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Viatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "eb" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "tipoTransporte" TEXT NOT NULL,
    "situacao" TEXT NOT NULL DEFAULT 'disponivel'
);
INSERT INTO "new_Viatura" ("eb", "id", "tipo", "tipoTransporte") SELECT "eb", "id", "tipo", "tipoTransporte" FROM "Viatura";
DROP TABLE "Viatura";
ALTER TABLE "new_Viatura" RENAME TO "Viatura";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
