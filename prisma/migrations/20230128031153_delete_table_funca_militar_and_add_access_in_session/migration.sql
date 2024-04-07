/*
  Warnings:

  - You are about to drop the `FuncaoMilitar` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "FuncaoMilitar";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "sessionToken" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,
    "access" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires" DATETIME NOT NULL,
    CONSTRAINT "Session_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Session" ("expires", "id", "militarId", "sessionToken") SELECT "expires", "id", "militarId", "sessionToken" FROM "Session";
DROP TABLE "Session";
ALTER TABLE "new_Session" RENAME TO "Session";
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
