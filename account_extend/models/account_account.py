from odoo import fields, models


class AccountAccount(models.Model):
    """account extend"""

    _inherit = "account.account"

    old_code = fields.Char(string="Old Code ")
