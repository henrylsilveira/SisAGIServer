-- CreateTable
CREATE TABLE "Feedback" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "dateFeedback" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "informacao" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Feedback_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
