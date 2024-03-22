package generator

import (
	"fmt"

	"android/soong/android"
)

func hzExpandVariables(ctx android.ModuleContext, in string) string {
	hzVars := ctx.Config().VendorConfig("hzVarsPlugin")

	out, err := android.Expand(in, func(name string) (string, error) {
		if hzVars.IsSet(name) {
			return hzVars.String(name), nil
		}
		// This variable is not for us, restore what the original
		// variable string will have looked like for an Expand
		// that comes later.
		return fmt.Sprintf("$(%s)", name), nil
	})

	if err != nil {
		ctx.PropertyErrorf("%s: %s", in, err.Error())
		return ""
	}

	return out
}
