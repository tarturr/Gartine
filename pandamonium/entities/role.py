import abc
from datetime import date, datetime

from pandamonium.database import Entity, column_filter
from pandamonium.security import max_size_filter


@column_filter
def hierarchy_filter(hierarchy: int):
    """Filtre pour une donnée de type hiérarchie.

    :param hierarchy: Emplacement du rôle dans la hiérarchie des rôles.

    :return: None si le numéro donné est compris entre 0 et 100, sinon un message d'erreur."""
    return 0 <= hierarchy <= 100


class Role(Entity, abc.ABC):
    def __init__(self,
                 uuid: str | None,
                 name: str | None,
                 color: str | None,
                 hierarchy: int | None,
                 admin: bool | None,
                 perm_managing_channels: str | None,
                 perm_managing_roles: str | None,
                 perm_delete: bool | None,
                 perm_ban: bool | None,
                 perm_kick: bool | None,
                 perm_mute: bool | None,
                 ):
        """Constructeur de la classe User. Crée automatiquement le nouvel utilisateur en base de données.

        Si une erreur survient, elle doit être gérée en utilisant les fonctions du module security.

        :param uuid: UUID du rôle.
        :param name: Nom du rôle.
        :param color: Couleur du rôle.
        :param hierarchy: Emplacement du rôle dans la hiérarchie des rôles.
        :param admin: Autorisation des permissions administrateur.
        :param perm_managing_channels: Autorisation de la permission d'ajouter, modifier et supprimer des channels.
        :param perm_managing_roles: Autorisation de la permission d'ajouter, modifier et supprimer des rôles.
        :param perm_delete: Autorisation de la permission de supprimer des messages.
        :param perm_ban: Autorisation de la permission de bannir des utilisateurs.
        :param perm_kick: Autorisation de la permission d'expulser des utilisateurs.
        :param perm_mute: Autorisation de la permission de rendre muet des utilisateurs.
        """
        super().__init__(
            'user',
            uuid,
            name=(
                name,
                max_size_filter(50, "Le nom donné à ce rôle est trop long (50 caractères maximum).")
            ),
            color=color,
            hierarchy=(hierarchy, hierarchy_filter),
            admin=admin,
            perm_managing_channels=(
                perm_managing_channels,
                max_size_filter(50, "???")
            ),
            perm_managing_roles=(
                perm_managing_roles,
                max_size_filter(50, "???")
            ),
            perm_delete=perm_delete,
            perm_ban=perm_ban,
            perm_kick=perm_kick,
            perm_mute=perm_mute
        )
