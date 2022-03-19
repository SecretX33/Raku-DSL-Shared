use Test;

use DSL::Shared::Roles::ErrorHandling;
use DSL::Shared::Roles::English::GlobalCommand;
use DSL::Shared::Roles::English::PipelineCommand;

grammar ParseObj
        does DSL::Shared::Roles::ErrorHandling
        does DSL::Shared::Roles::English::GlobalCommand
        does DSL::Shared::Roles::English::PipelineCommand {

    rule TOP { <pipeline-command> | <global-command> }
};


plan 16;

#-----------------------------------------------------------
# Global commands parsing
#-----------------------------------------------------------

## 1
ok ParseObj.parse('quit'),
        'quit';

## 2
ok ParseObj.parse('quit the session'),
        'quit the session';

## 3
ok ParseObj.parse('help'),
        'help';

## 4
ok ParseObj.parse('cancel'),
        'cancel';

## 5
ok ParseObj.parse('cancel request'),
        'cancel request';

## 6
ok ParseObj.parse('start over'),
        'start over';

## 7
ok ParseObj.parse('starting over'),
        'starting over';

## 8
ok ParseObj.parse('show all'),
        'show all';

## 9
ok ParseObj.parse('show all results'),
        'show all results';

## 10
ok ParseObj.parse('echo full result'),
        'echo full result';

## 11
ok ParseObj.parse('priority list'),
        'priority list';

## 12
ok ParseObj.parse('show prioritized list'),
        'show prioritized list';

## 13
ok ParseObj.parse('show pipeline value'),
        'show pipeline value';

## 14
ok ParseObj.parse('show current pipeline value'),
        'show current pipeline value';

## 15
ok ParseObj.parse('recover state'),
        'recover state';

## 16
ok ParseObj.parse('recover the last state'),
        'recover the last state';

done-testing;
