# tp-flutter_firebase
Projet Final - Application de Notes avec Firebase et Flutter

# Fonctionnalités
- Service d'authentification fonctionnel (inscripton, connexion et déconnexion)
- Affichage des notes propres utilisateur récupérer depuis la base de données Firebase
- Création, modification et suppression de notes depuis l'appli et sur la BDD
- Upload d'image depuis les fichiers du mobile avec demande d'autorisation (firebase storage)

/!\ la demande d'autorisation pour accèder aux fichiers peut ne pas fonctionné sur émulateur.

# Rapport
# Défis rencontrés: 
- Externalisation des widgets qui créer parfois des anomalies invisible
- Utilisation et compréhension de firebase, firestore, firebasefirestore...
- Doc Flutter (je l'a trouve PERSONNELLEMENT très très mauvaise)
- Doc Firebase (Encore pire, rien n'a marché)
- Récupération des fichiers du storage de firebase (upload ok mais pas d'affichage)


# Sécurité:
- Demande d'autorisation pour accèder aux fichiers du téléphone seulement si on essai de choisir une image
- Vérifications avant éxécution du code touchant à la BDD
- Prise en charge de quelques erreurs
