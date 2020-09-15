class RegularExpression {
  RegExp _emailRegExp;
  RegExp _passwordRegExp;
  RegExp _nameLastNameRegExp;
  RegExp _phoneRegExp;
  RegExp _personalIdentificationRegExp;
  RegExp _weightRegExp;
  RegExp _heightRegExp;

  RegularExpression() {
    _emailRegExp = new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
    _passwordRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');

    _nameLastNameRegExp = new RegExp(r'^([a-zA-Z ñáéíóú]{2,60})$');

    _phoneRegExp = new RegExp(r'^(\+57)?[ -]*(0|3)?([0-9]){10}$');
    _personalIdentificationRegExp = new RegExp(r'^[0-9]{6,10}$');

    _weightRegExp = new RegExp(r'^([0-9]+(\.[0-9][0-9]?)?)$');
    _heightRegExp = new RegExp(r'^([0-9]+(\.[0-9][0-9]?)?)$');
  }

  RegExp email() => this._emailRegExp;
  RegExp password() => this._passwordRegExp;
  RegExp name() => this._nameLastNameRegExp;
  RegExp phone() => this._phoneRegExp;
  RegExp identification() => this._personalIdentificationRegExp;
  RegExp weight() => this._weightRegExp;
  RegExp height() => this._heightRegExp;
}
