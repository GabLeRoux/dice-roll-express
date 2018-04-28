express = require('express')
router = express.Router()

rpgdice = require('rpgdicejs')

### GET users listing. ###

router.get '/:expression', (req, res) ->
  expression = req.params.expression
  results = rpgdice.parse(expression)
  roll = rpgdice.eval(results)
  data =
    expression: expression
    render: roll.render()
    value: roll.value
  res.send data

module.exports = router
