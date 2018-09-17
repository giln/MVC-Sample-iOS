import UIKit

protocol DataFetching {
    func fetchData(at url: URL, completion: @escaping (Data?, Error?) -> Void)
}

extension DataFetching {
    func fetchData(at url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared

        session.dataTask(with: url) { data, _, error in

            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
}

struct AppImage: Decodable {
    let label: String
}

struct App: Decodable {
    let name: String
    let summary: String
    let imageURLString: String

    private enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case summary
        case imageURLString = "im:image"
    }

    private enum LabelKeys: String, CodingKey {
        case label
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nameContainer = try container.nestedContainer(keyedBy: LabelKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .label)
        let summaryContainer = try container.nestedContainer(keyedBy: LabelKeys.self, forKey: .summary)
        summary = try summaryContainer.decode(String.self, forKey: .label)

        var imageLabels = [String]()
        var imagesContainer = try container.nestedUnkeyedContainer(forKey: .imageURLString)
        while !imagesContainer.isAtEnd {
            let imageContainer = try imagesContainer.nestedContainer(keyedBy: LabelKeys.self)
            let imageLabel = try imageContainer.decode(String.self, forKey: .label)

            imageLabels.append(imageLabel)
        }

        guard let firstImage = imageLabels.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [CodingKeys.imageURLString], debugDescription: "im:image cannot be empty"))
        }

        imageURLString = firstImage
    }
}

class AppsRessource: DataFetching {
    let url = URL(string: "https://itunes.apple.com/fr/rss/toppaidapplications/limit=50/json")!

    private struct Feed: Decodable {
        let entry: [App]
    }

    private struct ServerResponse: Decodable {
        let feed: Feed
    }

    func getTopApps(_ completion: @escaping ([App], Error?) -> Void) {
        fetchData(at: url) { data, error in
            var returnError = error

            var apps = [App]()
            defer {
                completion(apps, returnError)
            }

            guard let someData = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let serverResponse = try decoder.decode(ServerResponse.self, from: someData)
                apps = serverResponse.feed.entry
            }

            catch {
                returnError = error
            }
        }
    }
}

AppsRessource().getTopApps { _, error in
    print(error?.localizedDescription)
}

//
// extension AppsRessource {
//    func fetchData(at url: URL, completion: @escaping (Data?, Error?) -> Void) {
//        let testString = """
//        {
//            "feed": {
//                "author": {
//                    "name": {
//                        "label": "iTunes Store"
//                    },
//                    "uri": {
//                        "label": "http://www.apple.com/fr/itunes/"
//                    }
//                },
//                "entry": {
//                    "im:name": {
//                        "label": "Plague Inc."
//                    },
//                    "im:image": [{
//                            "label": "https://is1-ssl.mzstatic.com/image/thumb/Purple125/v4/82/73/ac/8273ac6c-b4e8-91d2-cacf-e0963fa06afe/AppIcon-1x_U007emarketing-85-220-0-6.png/53x53bb-85.png",
//                            "attributes": {
//                                "height": "53"
//                            }
//                        },
//                        {
//                            "label": "https://is3-ssl.mzstatic.com/image/thumb/Purple125/v4/82/73/ac/8273ac6c-b4e8-91d2-cacf-e0963fa06afe/AppIcon-1x_U007emarketing-85-220-0-6.png/75x75bb-85.png",
//                            "attributes": {
//                                "height": "75"
//                            }
//                        },
//                        {
//                            "label": "https://is2-ssl.mzstatic.com/image/thumb/Purple125/v4/82/73/ac/8273ac6c-b4e8-91d2-cacf-e0963fa06afe/AppIcon-1x_U007emarketing-85-220-0-6.png/100x100bb-85.png",
//                            "attributes": {
//                                "height": "100"
//                            }
//                        }
//                    ],
//                    "summary": {
//                        "label": "Pouvez-vous infecter le monde ? Plague Inc. est une combinaison unique entre stratégie poussée et simulation terriblement réaliste. \\n\\nVotre agent pathogène vient d'infecter le « Patient zéro ». Vous devez maintenant éradiquer l'humanité en faisant évoluer un virus mortel sur la planète tout en l'adaptant pour contrer tout ce que les êtres humains feront pour se défendre. \\n\\nDoté d'une réalisation brillante, ce jeu innovant a été entièrement pensé pour iPhone & iPad, Plague Inc. fait évoluer le genre stratégie et pousse le jeu nomade (et vous) dans ses retranchements. C'est vous contre le monde, seuls les plus forts survivront ! \\n\\n◈◈◈ jeu #1 avec plus de 500 millions d'installations ◈◈◈\\n\\nPlague Inc. est un hit international noté 5 étoiles par plus d'un demi-million de personnes cité dans des articles de journaux tels que The Economist, le New York Post, le Boston Herald, The Guardian et London Metro ! \\n\\nLes développeurs de Plague Inc. ont été invités à intervenir lors de la CDC à Atlanta sur l'épidémiologie dans le jeu !\\n\\n▶ « Le jeu crée un monde attachant qui implique le public sur des sujets de santé publique sérieux » – Les Centres pour le Contrôle et la Prévention des Maladies\\n▶ « Meilleur jeu sur tablette 2012 » - New York Daily News \\n▶ « Plague Inc. va capturer votre attention dans le bon sens du terme, et la garder » - Touch Arcade \\n▶ « Il est indéniable que Plague Inc. présente un haut niveau de qualité » - Modojo \\n▶ « Plague Inc. n'a pas le droit d'être aussi amusant » – London Metro \\n▶ « Il va vous donner envie de détruire le monde, rien que pour vous amuser un peu » – Pocket Lint \\n▶ « Le jeu dans Plague Inc. gameplay est contagieux » - Slide to Play \\n▶ Gagnant – « Meilleur jeu de l'année » – Pocket Gamer\\n▶ « Tuer par milliards n'a jamais été aussi amusant » – IGN \\n\\n◈◈◈\\n\\nFonctionnalités : \\n● Extraordinaires graphismes Retina et interface aux petits oignons (Contagion garantie) \\n● Monde hyper réaliste et extrêmement détaillé doté d'une IA complexe (Gestion au top) \\n● Aide intégrée au jeu très complète et didacticiel (Je suis une légende de l'aide) \\n● 12 types de maladie différents avec des stratégie radicalement différentes (12 singes ?) \\n● Fonctions complètes Sauvegarde/Chargement (28 Sauvegardes après !) \\n● Plus de 50 pays à infecter, des centaines de traits à faire évoluer et des milliers d'événements planétaires auxquels s'adapter (évolution pandémique) \\n● Prise en charge totale des classements et succès \\n● Extension rajoutant le Ver Neurax qui contrôle les esprits, le virus Necroa qui produit des zombies, le mode course et des scripts tirés de la vie réelle !\\n\\nTraduit en Anglais, Allemand, Espagnol, Portugais du Brésil, Italien, Français, Japonais, Coréen et Russe. (plus à venir bientôt) \\n\\nP.S. : vous pourrez vous féliciter si vous trouvez toutes les références littéraires ! \\n\\nPrix de vente spécial pour célébrer sa place de 5e jeu pour iPhone le plus populaire de 2015 !\\n\\n◈◈◈\\n\\nAimez Plague Inc. sur Facebook : \\nhttp://www.facebook.com/PlagueInc \\n\\nSuivez-nous sur Twitter : \\nwww.twitter.com/NdemicCreations"
//                    },
//                    "im:price": {
//                        "label": "0,99 €",
//                        "attributes": {
//                            "amount": "0.99000",
//                            "currency": "EUR"
//                        }
//                    },
//                    "im:contentType": {
//                        "attributes": {
//                            "term": "Application",
//                            "label": "Application"
//                        }
//                    },
//                    "rights": {
//                        "label": "© 2011, Ndemic Creations LTD"
//                    },
//                    "title": {
//                        "label": "Plague Inc. - Ndemic Creations"
//                    },
//                    "link": {
//                        "attributes": {
//                            "rel": "alternate",
//                            "type": "text/html",
//                            "href": "https://itunes.apple.com/fr/app/plague-inc/id525818839?mt=8&uo=2"
//                        }
//                    },
//                    "id": {
//                        "label": "https://itunes.apple.com/fr/app/plague-inc/id525818839?mt=8&uo=2",
//                        "attributes": {
//                            "im:id": "525818839",
//                            "im:bundleId": "com.ndemiccreations.plagueinc"
//                        }
//                    },
//                    "im:artist": {
//                        "label": "Ndemic Creations",
//                        "attributes": {
//                            "href": "https://itunes.apple.com/fr/developer/ndemic-creations/id525818842?mt=8&uo=2"
//                        }
//                    },
//                    "category": {
//                        "attributes": {
//                            "im:id": "6014",
//                            "term": "Games",
//                            "scheme": "https://itunes.apple.com/fr/genre/ios-jeux/id6014?mt=8&uo=2",
//                            "label": "Jeux"
//                        }
//                    },
//                    "im:releaseDate": {
//                        "label": "2012-05-25T17:54:37-07:00",
//                        "attributes": {
//                            "label": "25 25 2012"
//                        }
//                    }
//                },
//                "updated": {
//                    "label": "2018-06-08T05:57:26-07:00"
//                },
//                "rights": {
//                    "label": "Copyright 2008 Apple Inc."
//                },
//                "title": {
//                    "label": "iTunes Store : Classement des apps payantes"
//                },
//                "icon": {
//                    "label": "http://itunes.apple.com/favicon.ico"
//                },
//                "link": [{
//                        "attributes": {
//                            "rel": "alternate",
//                            "type": "text/html",
//                            "href": "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?cc=fr&id=50&popId=30"
//                        }
//                    },
//                    {
//                        "attributes": {
//                            "rel": "self",
//                            "href": "https://itunes.apple.com/fr/rss/toppaidapplications/limit=1/json"
//                        }
//                    }
//                ],
//                "id": {
//                    "label": "https://itunes.apple.com/fr/rss/toppaidapplications/limit=1/json"
//                }
//            }
//        }
//        """
//        completion(testString.data(using: .utf16), nil)
//    }
// }
