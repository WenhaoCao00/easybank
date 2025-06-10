package api

import (
	"github.com/WenhaoCao00/easybank/util"
	"github.com/go-playground/validator/v10"
)

var validCurrency validator.Func = func(fieldLevel validator.FieldLevel) bool {
	if currency, ok := fieldLevel.Field().Interface().(string); ok{
		//check if currency is support
		return util.IsSupportedCurrency(currency)
	}
	return false
}