/*==============================================================*/
/* EXERCICE 3 : REQUETAGE                                       */
/*==============================================================*/

/* Question 1 */

SELECT n56, (n57+n58+n59) AS results FROM import;

/* Question 2 */

SELECT count(*) AS results FROM import 
WHERE n56<>(n57+n58+n59);
-- En faisant cette requete on constate que la valeur renvoyer est 0.
-- Cela veut donc dire que le re-calcul est parfaitement exact car on demande les différences.

/* Question 3 */

SELECT n74, (n51 / n47)*100 AS results FROM import 
WHERE n47<>0;

/* Question 4 */

SELECT ((count(*)*100.00)/13869.00) AS results FROM import 
WHERE round(n74) <> round((n51 / n47) * 100) AND n47 <> 0;
-- On effectue ici un round sur les résultats car les données de parcoursup arrondissent les valeurs des calculs.

/* Question 5 */

SELECT n76, (n53/n47)*100 AS results FROM import 
WHERE n47<>0;
-- Comme sur la question précedente les valeurs sont arrondi pour la colonne n76.
-- Les valeurs sont donc exact uniquement sur les valeurs entières.

/* Question 6 */

SELECT round((round(nbAdmRecuPropAdmAvantFinProcPrinc)/round(nbTotCandAcceptePropAdm))*100) AS results FROM Candidatures 
WHERE nbTotCandAcceptePropAdm<>0;
-- On effectue ici un round sur les résultats car les données de parcoursup arrondissent les valeurs des calculs.

/* Question 7 */

SELECT n81, round((round(n55)/round(n56))*100) AS results FROM import 
WHERE n56<>0;
-- Comme sur la question précedente les valeurs sont arrondi pour la colonne n76.
-- Les valeurs sont donc exact uniquement sur les valeurs entières.

/* Question 8 */

SELECT round((round(b.nbAdmBoursiersNeoBac)/round(c.nbAdmNeoBac))*100) AS results 
FROM Candidatures AS c JOIN Boursiers AS b ON c.codeForm=b.codeForm 
WHERE c.nbAdmNeoBac<>0;