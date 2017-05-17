# Test

Ce test est assez typique : il s'agit de réaliser une toute petite app web, 
en utilisant les outils de notre stack (Ruby, Rails, HTML5, Git, etc.), et 
en abordant toutes les disciplines et compétences nécessaires pour intégrer 
notre équipe : intégration HTML et CSS, développement RoR, tests, et contrôle 
de source.

## L'app

Il s'agit de travailler sur une app de suivi de publication, dans le but de 
faciliter la facturation à nos clients. (Cette app est réellement en cours 
de réalisation chez nous en ce momet, BTW.)

Le besoin est relativement simple : chaque jour, plusieurs annonces sont 
diffusées sur le site [app.keycoopt.com]. Ces annonces doivent ensuite être 
facturées au client pour le compte duquel l'annonce est diffusée. L'application 
Keycoopt elle-même ne gère pas la facturation, mais elle peut, via des _webhooks_, 
alerter une _autre_ application qui, elle, se chargera de cette facturation.

C'est cette autre application qu'il faut réaliser.

Cette app doit pouvoir :

1.  Recevoir une requête HTTP annonçant la publication d'une annonce
2.  Réagir à cette publication en envoyant un e-mail à la personne en charge des factures
3.  Exposer, via une interface web sécurisée, la liste des annonces publiées depuis une date donnée
4.  Être capable de générer une facture, pour n'importe quelle annonce, au format PDF

L'app doit être écrite avec Rails, en version 4.2 ou supérieur, et mise sous contrôle de source avec Git.

### 1. Recevoir une requête HTTP

Un point d'entrée (au choix : `monapp.example.com/events/new`, `monapp.example.com/webhooks`, 
`monapp.example.com/publication`… tout est permis) doit être exposé. Ce point d'entrée recevra 
occasionnellement une requête HTTP `POST`, avec un _payload_ au format JSON représentant l'annonce 
qui vient d'être publiée. (Un exemple de requête est fourni en annexe.)

L'app doit parser ce _payload_ pour en extraire les informations pertinentes, et enregistrer ces 
informations de façon à pouvoir les exposer par la suite (cf. point 3). Attention, si l'annonce a 
déjà été traitée et enregistrée, l'app ne doit *pas* créer de nouvel enregistrement, mais ignorer 
la requête.

Elle doit également envoyer une notification par e-mail (voir point suivant).

En réponse à cette requête, l'app doit renvoyer un code HTTP 201 si la requête a abouti à l'enregistrement 
de données, ou un code HTTP 204 si ce n'est pas le cas.

### 2. Envoyer un e-mail d'alerte

Lorsqu'une _nouvelle_ publication d'annonce est reçue et traitée, un email doit être envoyé à 
l'adresse `facturation@example.com`. Cet e-mail doit contenir le texte suivant :

    Bonjour,
    
    Une nouvelle annonce, [TITRE DE L'ANNONCE] vient d'être publiée, et peut être
    facturée au client [NOM DU CLIENT].
    
    Pour générer la facture, rendez-vous sur la page [URL DE L'APP].
    
    Bonne journée !

Cet email peut être au format texte, ou (idéalement) aux formats texte *et* HTML.

*Attention*, il est préférable d'envoyer cet e-mail de façon asynchrone, via un _job_, même si ce n'est 
pas obligatoire.

### 3. Exposer une interface web

L'app doit également, via une autre URL (p.ex `monapp.example.com/job_offers`, `monapp.example.com/publications`, etc.), 
permettre à un utilisateur de consulter la liste des annonces publiées.

La page web concernée doit afficher la liste des annonces publiées, de la façon suivante :

| Client  | Annonce                     | Date de publication | Facture                |
|---------|-----------------------------|---------------------|------------------------|
| L'Oréal | Directeur Financier H/F     | 12/05/2017          | Générer                |
| Apple   | Responsable marketing H/F   | 10/04/2017          | #APP5678 (télécharger) |
| Triumph | Chef d'atelier              | 06/03/2017          | #TRI1234 (télécharger) |

*   La première colonne contient le nom du client
*   La seconde colonne contient le titre de l'annonce
*   La troisième colonne contient la date de publication
*   La quatriène colonne contient :
    *   Un lien pour générer la facture, si celle-ci n'a pas encore été générée (cf. point 4)
    *   La référence de la facture et un lien pour la télécharger, si elle a déjà été générée

#### Sécurisation de l'interface

L'interface doit être d'accès limité, contrôlé par un identifiant (`facturation@example.com`) et un 
mot de passe (`password`).

**Attention** : cette authentification peut être de n'importe quel type (HTTP Basic, utilisation d'un 
modèle `User`, etc.), mais la solution choisie doit être implémentée **sans recourir à une gem tierce** 
(Devise ou autre).

#### Design et intégration

L'interface web doit être correctement intégrée, en utilisant :

*   HTML5 (en veillant à la sémantique)
*   CSS, ou idéalement Sass

Le design est laissé libre ; à titre d'exemple (ambitieux) une maquette du back-office actuel de Keycoopt 
est fourni en annexe. (Cet exemple ayant été conçu et intégré par des développeurs expérimenté, un 
rendu identique n'est pas attendu ; il s'agit bien d'un *exemple*).

**Attention** : même si le recours à des frameworks CSS comme Bootstrap ou Foundation est autorisé, 
un minimum de travail en CSS est attendu. Utiliser un tel framework tel quel sera mal considéré.

### 4. Générer une facture

Pour chaque annonce, une (_et une seule_) facture peut être générée. Cette facture doit comporter 
quelques informations tirées de l'annonce, et **une référence générée automatiquement par l'app**. 
Dans le détail, il faut :

*   Nom du client
*   Titre de l'annonce
*   Date de publication de l'annonce
*   Date de facturation (c-.à-d. date de création de la facture)
*   Montant : 1234,56€
*   Référence unique de la facture

La génération de la référence doit se faire selon la formule suivante :

    (4 première lettres, en majuscules et sans accent, du nom du client) + ID unique de 4 chiffres ou plus

Chaque référence doit être **unique** ; en cas de collision, une nouvelle référence doit être générée.

Une fois créé, la facture d'une annonce peut être affichée en HTML, ou téléchargée au format PDF. La 
façon de générer ce PDF est libre et peut faire appel à un moteur de rendu comme `wkhtmltopdf`, mais 
ce n'est pas obligatoire. (Pour ce test, le rendu de la facture lui-même peut être sommaire, du moment 
qu'il contient toutes les informations demandées.)

## Contraintes

Pour ce test, outre les contraintes techniques (utilisation de Rails, etc.), deux choses sont imposées :

*   L'app doit être accompagnée de (au moins) quelques tests.
    Ces tests peuvent être écrits avec, au choix, Minitest ou RSpec. Les types de test (système, 
    intégration, unitaire. etc.) sont laissés au libre arbitre du candidate
*   L'app doit être sous contrôle de source avec Git.
    Le candidat devra veiller à morceller son travail en nombreux petit commits logiques (par exemple : premier test, 
    première implémentation, second test, seconde implémentation, etc.) plutôt qu'en une poignée de gros 
    commits. Des messages de commit qui expliquent en détail chaque étape seront fortement appréciés.

## Annexes

### Exemple de requête HTTP avec le _payload_ d'une publication

```
POST HTTP/1.1
Content-Type: application/vnd.api+json
Accept: application/vnd.api+json

{
  "data": {
    "type": "publication",
    "attributes": {
      "job_offer": {
        "title": "Responsable commercial H/F",
        "description": "Spécialisé dans la <strong>prestation intellectuelle d’expertise IT</strong>, notre client recherche aujourd’hui un Responsable Commercial (H/F).\n\nAfin d’accompagner leur croissance, le candidat devra déployer et installer durablement leur présence dans le Finistère.\n\nSous la responsabilité du Directeur Commercial, le candidat aura pour missions de :\n\n• Répondre aux appels d’offres.\n• Identifier, prospecter et promouvoir l’offre auprès d’autres interlocuteurs afin d’en accroître sa présence et recueillir de nouveaux besoins.\n• Superviser la réalisation contractuelle avec les clients et partenaires, assurer le suivi des missions et veiller à la satisfaction client.\n• Concrétiser de nouveaux référencements régionaux par la signature d’affaires et participer au gain de référencements nationaux.\n\nDe formation supérieure (Bac+5), issu d’Ecole de Commerce ou d’Ingénieurs, le candidat dispose d’une expérience significative en SSII la vente de services complexes sur mesure. Il bénéficie également d’une expérience dans la gestion commerciale de grands comptes et est capable de construire des offres adaptées. Il a une excellente connaissance du bassin économique de la métropole lilloise.\n\nDoté de véritables qualités d’écoute, force de proposition, réactif, il sait convaincre ses clients autant que ses partenaires. Vif et créatif, il a su démontrer une forte habilité à nouer des relations commerciales pérennes avec ses clients.",
        "customer": {
          "name": "L'Oréal"
        }
      }
    }
  }
}
```
