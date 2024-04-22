//
//  enable_tso.c
//  learingC
//
//  Created by Rohaan on 08/02/2024.
//

#include "enable_tso.h"

__attribute__((constructor)) static void set_tso() {
    int new = 1;
    sysctlbyname("kern.tso_enable", NULL, NULL, &new, sizeof(new));
}

static atomic_size_t arena_top = sizeof(context_arena) / sizeof(*context_arena);

static void *set_tso_trampoline(void *argument) {
    set_tso();
    pthread_context *context = (pthread_context *)argument;
    return context->function(context->argument);
}

int overriden_pthread_create(pthread_t *thread, const pthread_attr_t *attr, void *(*start_routine)(void *), void *arg) {
    size_t context;
    if ((context = --arena_top)) {
        context_arena[context] = (pthread_context){start_routine, arg};
        return pthread_create(thread, attr, set_tso_trampoline, context_arena + context);
    } else {
        return EAGAIN;
    }
}
